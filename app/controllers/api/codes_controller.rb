class Api::CodesController < ApplicationController
  before_action :set_version

  def create
  end

  def update
  end

  private

  def set_version
    @version = Version.find_by(project_id: params[:project_id], id: params[:version])
  end
end
