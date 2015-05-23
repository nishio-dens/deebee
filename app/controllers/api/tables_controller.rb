class Api::TablesController < ApplicationController
  def index
    version = Version.find_by(project_id: params[:project_id], id: params[:version])
    data = version.tables.order(:name).map do |table|
      {
        id: table.id.to_s,
        text: table.name,
        img: 'icon-page'
      }
    end
    render json: data
  end
end
