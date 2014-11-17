class Admin::ProjectTasksController < Admin::BaseController

  before_filter :check_referer_host, only: [:destroy]


  def destroy
    project_task = ProjectTask.find params[:id]
    project = project_task.project
    if project_task.destroy
      render partial: "admin/projects/tasks_list", locals: {project_tasks: project.project_tasks}
    else
      flash[:error] = "Une erreur s'est produite lors de la suppression de la tache"
      render nothing: true
    end
  end
end