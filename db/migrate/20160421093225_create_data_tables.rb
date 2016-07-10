class CreateDataTables < ActiveRecord::Migration
  def change
    create_table :namespaces do |t|
      t.column :name, :string, null: false

      t.index :name, unique: true
    end

    create_table :metrics do |t|
      t.column :namespace_id, :integer, null: false
      t.column :name, :string, null: false

      t.index [:namespace_id, :name], unique: true
    end

    create_table :dimensions do |t|
      t.column :metric_id, :integer, null: false
      t.column :cardinality, :integer, null: false
      t.column :group, :string, null: false
      t.column :key, :string, null: false

      t.index [:metric_id, :key], unique: true
      t.index [:metric_id, :cardinality, :group]
    end

    create_table :daily_records do |t|
      t.column :dimension_id, :integer, null: false
      t.column :date, :string, null: false
      t.column :value, :float, null: false

      t.index [:dimension_id, :date], unique: true
    end
  end
end
