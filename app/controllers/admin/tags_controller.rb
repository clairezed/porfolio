class Admin::TagsController < Admin::BaseController

  before_filter :check_referer_host, only: [:autocomplete]

  respond_to :json, only: [:autocomplete]

  def index
    @tags = Tag.order(:created_at)
  end

  def autocomplete
    result = params[:val].blank? ? [] : Tag.by_title(params[:val].to_s)
    respond_with result
  end

  def check
    tag = Tag.where(title: params[:tag_title]).first_or_create
    # raise params[:project_id].inspect
    project = Project.find params[:project_id]
    if project.project_tags.create(tag_id: tag.id)
      render partial: "admin/projects/tags_list", locals: {project_tags: project.project_tags}
    else
      flash[:error] = "Une erreur s'est produite lors de la création du projet"
      render nothing: true
    end
  end

  def destroy
    @tag = Tag.find params[:id]
    begin
      flash[:notice] = "Le tag a bien été supprimé" if @tag.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      flash[:error] = "Ce tag ne peut être supprimé car des éléments lui sont dépendants"
    end
    redirect_to admin_tags_path
  end

end