class Admin::ProjectTasksController < Admin::BaseController

  before_filter :check_referer_host, only: [:destroy]
  before_filter :find_project_and_project_task

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
    if @project_task.destroy
      render partial: "admin/projects/tasks_list", locals: {project_tasks: @project.project_tasks}
    else
      flash[:error] = "Une erreur s'est produite lors de la suppression de la tâche"
      render nothing: true
    end
  end

  private

  def find_project_and_project_task
    @project_task = ProjectTask.find params[:id]
    @project = @project_task.project
  end

end