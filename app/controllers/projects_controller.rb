class ProjectsController < ApplicationController

  def index
    @projects = Project.visible.order(position: :asc)
  end

  def show
    @project = Project.from_param params[:id]
  end
end

