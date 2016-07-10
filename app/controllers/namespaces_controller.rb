class NamespacesController < ApplicationController
  # GET /namespaces
  def index
    @namespaces = Namespace.all
  end
end
