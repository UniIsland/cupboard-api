# == Schema Information
#
# Table name: daily_records
#
#  id           :integer          not null, primary key
#  dimension_id :integer          not null
#  date         :string(255)      not null
#  value        :float(24)        not null
#
# Indexes
#
#  index_daily_records_on_dimension_id_and_date  (dimension_id,date) UNIQUE
#

class DailyRecord < ApplicationRecord
  attr_readonly :date, :dimension_id

  belongs_to :dimension

  validates :date, format: { with: /\d{4}-\d{2}-\d{2}/ }, on: :create
  validates :dimension, presence: true, on: :create
  validates :value, numericality: true
  validate :valid_date_string, on: :create

  # default_scope { includes :dimension }

  private

  def valid_date_string
    Date.strptime date, '%Y-%m-%d'
  rescue ArgumentError
    errors.add :date
  end
end
