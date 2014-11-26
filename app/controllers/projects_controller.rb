class ProjectsController < ApplicationController

  def index
    @tags = Tag.having_projects.order(:title)
    @projects = Project.visible.apply_filters(params).order(position: :asc)
  end

  def show
    @project = Project.from_param params[:id]
    @previous_project = @project.previous
    @next_project = @project.next
  end
end

