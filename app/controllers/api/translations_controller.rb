class Api::TranslationsController < ApplicationController
  before_action :set_project

  def index
    @translations = Translation
      .all
      .where(project_id: @project.id)
      .order(:variable_name, id: :desc)
  end

  def create
    @translation = Translation
      .new(registerable_params.merge(project_id: @project.id))
    if @translation.save
      render :success
    else
      @messages = @translation.errors.full_messages.join("\n")
      render :failure
    end
  end

  def update
    @translation = Translation
      .where(project_id: @project.id)
      .find(params[:id])

    if @translation.update(registerable_params)
      render :success
    else
      @messages = @translation.errors.full_messages.join("\n")
      render :failure
    end
  end

  def destroy
    @translation = Translation
      .where(project_id: @project.id)
      .find(params[:id])
    @translation.destroy
    render :success
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def registerable_params
    rp = params.permit(:variableName, :ja, :en)
    Hash[rp.map { |k, v| [k.underscore, v] }]
  end
end
