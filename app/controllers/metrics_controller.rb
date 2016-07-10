class MetricsController < ApplicationController
  # GET /metrics?namespace=:namespace
  def index
    @metrics = Namespace.find_by!(name: namespace_param).metrics.all
  end

  private

  def namespace_param
    params.require :namespace
  end
end
