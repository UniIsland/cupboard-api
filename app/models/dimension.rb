# == Schema Information
#
# Table name: dimensions
#
#  id          :integer          not null, primary key
#  metric_id   :integer          not null
#  key         :string(255)      not null
#  cardinality :integer          not null
#
# Indexes
#
#  index_dimensions_on_metric_id_and_cardinality  (metric_id,cardinality)
#  index_dimensions_on_metric_id_and_key          (metric_id,key) UNIQUE
#

class Dimension < ApplicationRecord
  GROUP_FORMAT = /[a-z][a-z0-9_]*[a-z0-9](\|[a-z][a-z0-9_]*[a-z0-9])*/
  KEY_FORMAT = /[a-z][a-z0-9_]*[a-z0-9]:[a-z][a-z0-9_]*[a-z0-9](\|[a-z][a-z0-9_]*[a-z0-9]:[a-z][a-z0-9_]*[a-z0-9])*/

  attr_readonly :metric_id, :cardinality, :group, :key

  belongs_to :metric
  has_many :daily_records

  validates :metric, presence: true, on: :create
  validates :cardinality, numericality: { greater_than_or_equal_to: 0, only_integer: true }, on: :create
  validates :group, format: { with: GROUP_FORMAT }, allow_blank: true, on: :create
  validates :key, format: { with: KEY_FORMAT }, allow_blank: true, on: :create
  validates :key, uniqueness: { scope: :metric_id }, on: :create

  before_validation :case_down_and_sort, on: :create
  before_validation :set_cardinality_and_group, on: :create

  # default_scope { includes :metric }

  private

  def case_down_and_sort
    return if key.blank?
    self[:key] = self[:key].downcase.split('|').sort.join('|')
  end

  def set_cardinality_and_group
    self[:cardinality] = key.split('|').size
    self[:group] = key.gsub /:\w+/, ''
  end
end
