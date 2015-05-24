class Api::TablesController < ApplicationController
  before_action :set_version

  def index
    data = @version.tables.order(:name).map do |table|
      {
        id: table.id.to_s,
        text: table.name,
        img: 'icon-page'
      }
    end
    render json: data
  end

  def show
    table = @version.tables.find(params[:id])
    columns = table.columns.order(:id)
    render json: columns
  end

  private

  def set_version
    @version = Version.find_by(project_id: params[:project_id], id: params[:version])
  end
end
