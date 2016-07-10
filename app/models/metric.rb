# == Schema Information
#
# Table name: metrics
#
#  id           :integer          not null, primary key
#  namespace_id :integer          not null
#  name         :string(255)      not null
#
# Indexes
#
#  index_metrics_on_namespace_id_and_name  (namespace_id,name) UNIQUE
#

class Metric < ApplicationRecord
  attr_readonly :name, :namespace_id

  belongs_to :namespace
  has_many :dimensions
  # has_many :daily_records, through: :dimensions

  validates :name, format: { with: /[a-z][a-z0-9_]+[a-z0-9]/ }, on: :create
  validates :name, uniqueness: { scope: :namespace_id }, on: :create

  before_validation :case_down, on: :create

  def main_dimension
    @main_dimension ||= dimensions.where(cardinality: 0).take!
  end

  def dimension_groups
    dimensions.select(:group).distinct.order(:cardinality, :group).pluck(:group)
  end

  def dimension_keys_for_group(group)
    card = group.count('|') + 1
    dimensions.where(cardinality: card, group: group).order(:key).pluck(:key)
  end

  private

  def case_down
    self[:name] = self[:name].try(:downcase)
  end
end
