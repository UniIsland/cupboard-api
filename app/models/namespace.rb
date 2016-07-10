# == Schema Information
#
# Table name: namespaces
#
#  id   :integer          not null, primary key
#  name :string(255)      not null
#
# Indexes
#
#  index_namespaces_on_name  (name) UNIQUE
#

class Namespace < ApplicationRecord
  attr_readonly :name

  has_many :metrics

  validates :name, format: { with: /[a-z][a-z0-9_]+[a-z0-9]/ }, on: :create
  validates :name, uniqueness: true, on: :create

  before_validation :case_down, on: :create

  def path
    "/#{name}"
  end

  def label
    name.titleize
  end

  private

  def case_down
    self[:name] = self[:name].try(:downcase)
  end
end
