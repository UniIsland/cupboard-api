class DataController < ApplicationController
  helper_method :nullify_missing_dates

  def daily
    @dimensions = if dimensions_param.size == 0
      [current_metric.main_dimension]
    else
      current_metric.dimensions.where(key: dimensions_param).all
    end
  end

  def dimension_groups
    @groups = current_metric.dimension_groups
  end

  def dimensions
    @dimension_keys = current_metric.dimension_keys_for_group params.require(:group)
  end

  private

  def nullify_missing_dates(records)
    series = []
    last_date = nil
    records.sort_by {|r| r.date} .each do |r|
      d = Date.parse(r.date)
      while last_date && (last_date += 1) < d
        n = r.dup
        n.date = last_date.strftime
        n.value = nil
        series << n
      end
      series << r
      last_date = d
    end
    series
  end

  def current_metric
    @current_metric ||= Metric.joins(:namespace).where(
      namespaces: {name: params.require(:namespace)},
      name: params.require(:metric)
    ).take!
  end

  def dimensions_param
    params[:dimensions].is_a?(Array) ? params[:dimensions] : []
  end
end
