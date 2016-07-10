require 'csv'
require 'fileutils'

namespace :import do
  desc "import tsv files"
  task tsv: :environment do
    TSV_DIR = Rails.root + 'tmp/tsv'
    BACKUP_DIR = Rails.root + 'tmp/tsv_backup/'
    CSV_OPT = {
      headers: true,
      col_sep: "\t",
    }

    def process_header(headers, namespace)
      raise "column name must be lowercase" unless headers.all? {|h| h == h.downcase}
      raise "first column must be 'date'" unless headers[0] == "date"
      dimensions = []
      metrics = []
      headers[1..-1].each do |h|
        (h[-1] == ':' ? dimensions : metrics) << h
      end
      ns = Namespace.find_or_create_by! name: namespace
      metrics.collect! { |m| ns.metrics.find_or_create_by! name: m }
      [metrics, dimensions.sort]
    end

    def read_tsv(fn)
      namespace = fn.basename.to_s[/^(\w+)-\d\d\./, 1].try(:downcase) || 'zhihu'
      # raise "no namespace specified" if namespace.nil?

      header_processed = false
      record_updated = 0
      metrics = dimensions = nil
      CSV.foreach(fn, CSV_OPT) do |row|
        unless header_processed
          metrics, dimensions = process_header row.headers, namespace
          header_processed = true
        end
        metrics.each do |m|
          key = dimensions.reject {|d| row[d].upcase == 'NULL'} .collect {|d| [d,row[d].downcase].join} .join('|')
          dimension = m.dimensions.find_or_create_by! key: key
          record = dimension.daily_records.find_or_initialize_by date: row['date']
          record.value = row[m.name].to_f
          record.save!
          record_updated += 1
        end
      end
      return record_updated
    end

    def archive_tsv(fn)
      FileUtils.mv fn, BACKUP_DIR, verbose: true, force: true
    end

    BACKUP_DIR.mkpath
    TSV_DIR.each_child do |fn|
      puts "reading #{fn} :"
      record_updated = read_tsv fn
      puts "\t#{record_updated} records wrote to database."
      archive_tsv fn
    end
  end
end
