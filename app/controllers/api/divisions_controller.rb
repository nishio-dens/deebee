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
    division = Division.find(params[:id])
    codes = division
      .codes
      .order(:code_value)
      .map { |record| record.as_json.merge(recid: record.id) }
    data = {
      total: codes.count,
      records: codes
    }
    render json: data
  end

  def create
    division = Division.new(version_id: @version.id)
    division.attributes = new_attributes
    division.save!
    render json: {
      id: division.id.to_s,
      text: division.name,
      img: 'icon-page'
    }
  end

  def destroy
    division = @version.divisions.find(params[:id])
    division.destroy!
    render nothing: true
  end

  private

  def set_version
    @version = Version.find_by(project_id: params[:project_id], id: params[:version])
  end

  def new_attributes
    params.required(:record).permit(:name, :description)
  end
end
