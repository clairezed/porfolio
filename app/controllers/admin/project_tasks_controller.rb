class Admin::ProjectTasksController < Admin::BaseController

  before_filter :check_referer_host, only: [:destroy]
  before_filter :find_project_and_project_task, only: [:position, :destroy]

  def create
    @project = Project.find(params[:project_id])
    @project_task = ProjectTask.initialize_from_project(params.permit(:title, :project_id))
    unless @project_task.save
      flash[:error] = "Une erreur s'est produite lors de la création du tag"
    end
    render partial: "admin/projects/tasks_list", locals: {project_tasks: @project.project_tasks}
  end

  def position
    if params[:position].present?
      @project_task.insert_at params[:position].to_i
      render partial: "admin/projects/tasks_list", locals: {project_tasks: @project.project_tasks}
    else
      flash[:error] = "Une erreur s'est produite lors de la réorganisation des tâches"
      render nothing: true
    end
  end

  def destroy
    unless @project_task.destroy
      flash[:error] = "Une erreur s'est produite lors de la suppression de la tâche"
    end
    render partial: "admin/projects/tasks_list", locals: {project_tasks: @project.project_tasks}
  end

  private

  def find_project_and_project_task
    @project_task = ProjectTask.find params[:id]
    @project = @project_task.project
  end

end