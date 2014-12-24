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

  def destroy
    @task = Task.find params[:id]
    begin
      flash[:notice] = "La tâche a bien été supprimée" if @task.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      flash[:error] = "Cette tâche ne peut être supprimée car des éléments lui sont dépendants"
    end
    redirect_to admin_tasks_path
  end

end