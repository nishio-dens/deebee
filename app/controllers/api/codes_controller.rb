class Api::CodesController < ApplicationController
  before_action :set_version
  before_action :set_division

  def create
    code = Code.new(division: @division)
    code.attributes =
    if code.save
    end
  end

  def update
  end

  private

  def set_version
    @version = Version.find_by(project_id: params[:project_id], id: params[:version])
  end

  def set_division
    @division = @version.divisions.find(params[:division_id])
  end
end
