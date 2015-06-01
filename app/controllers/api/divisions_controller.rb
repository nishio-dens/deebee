class Api::DivisionsController < ApplicationController
  before_action :set_version

  def index
    data = @version.divisions.order(:name).map do |division|
      {
        id: division.id.to_s,
        text: division.name,
        img: 'icon-page'
      }
    end
    render json: data
  end

  def show
    division = @version.divisions.find(params[:id])
  end

  private

  def set_version
    @version = Version.find_by(project_id: params[:project_id], id: params[:version])
  end
end