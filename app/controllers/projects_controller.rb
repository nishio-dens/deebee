class ProjectsController < ApplicationController
  def index
    @projects = Project.all.order(id: :desc)
  end
end
