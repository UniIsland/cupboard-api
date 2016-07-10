class DataController < ApplicationController
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
