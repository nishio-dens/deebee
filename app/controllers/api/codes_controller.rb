class Api::CodesController < ApplicationController
  before_action :set_version
  before_action :set_division

  def create
    code = Code.new(division: @division)
    code.attributes = code_attributes
    if code.save
      render json: code.as_json.merge(recid: code.id)
    else
      fail 'Invalid Request'
    end
  end

  def update
    code = @division.codes.find(params[:id])
    if code.update_attributes(code_attributes)
      render json: code
    else
      fail 'Invalid Request'
    end
  end

  def destroy
    code = @division.codes.find(params[:id])
    code.destroy
    render nothing: true
  end

  private

  def set_version
    @version = Version.find_by(project_id: params[:project_id], id: params[:version])
  end

  def set_division
    @division = @version.divisions.find(params[:division_id])
  end

  def code_attributes
    params.require(:record).permit(:code_value, :name, :alias, :comment)
  end
end
