class Admin::TasksController < Admin::BaseController

  before_filter :check_referer_host, only: [:autocomplete]

  respond_to :json, only: [:autocomplete]

  def index
    params[:sort] ||= "sort_by_created_at desc"
    @tasks = Task.apply_filters(params).paginate(per_page: 10, page: params[:page])
  end

  def autocomplete
    result = params[:val].blank? ? [] : Task.by_title(params[:val].to_s)
    respond_with result
  end

  def check
    task = Task.where(title: params[:task_title]).first_or_create
    # raise params[:project_id].inspect
    project = Project.find params[:project_id]
    if project.project_tasks.create(task_id: task.id)
      render partial: "admin/projects/tasks_list", locals: {project_tasks: project.project_tasks}
    else
      flash[:error] = "Une erreur s'est produite lors de la création du projet"
      render nothing: true
    end
  end

  def destroy
    @task = Task.find params[:id]
    begin
      flash[:notice] = "Le tâsk a bien été supprimé" if @task.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      flash[:error] = "Ce tâsk ne peut être supprimé car des éléments lui sont dépendants"
    end
    redirect_to admin_tasks_path
  end

end