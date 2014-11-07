class Admin::ProjectsController < Admin::BaseController

  before_filter :find_project, only: [ :edit, :update, :destroy, :position, :sort_picture ]

  def index
    params[:sort] ||= "sort_by_created_at desc"
    @projects = Project.apply_filters(params).paginate(per_page: 10, page: params[:page])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      (params[:project][:new_pictures] || []).each do |idx, picture_params|
        @project.pictures << Asset::ProjectPicture.new(picture_params)
      end
      flash[:notice] = "La référence a été créée avec succès"
      redirect_to params[:continue].present? ? edit_admin_project_path(@project) : admin_projects_path
    else
      flash[:error] = "Une erreur s'est produite lors de la création de la référence"
      render :new
    end
  end

  def edit
  end

  def update
    @project.attributes = project_params

    if @project.save
      (params[:project][:new_pictures] || []).each do |idx, picture_params|
        @project.pictures << Asset::ProjectPicture.new(picture_params)
      end
      flash[:notice] = "La référence a été mise à jour avec succès"
      redirect_to params[:continue].present? ? edit_admin_project_path(@project) : admin_projects_path
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de la référence"
      render :edit
    end
  end

  def position
    if params[:position].present?
      @project.insert_at params[:position].to_i
      flash[:notice] = "Les références ont été réordonnées avec succès"
    end
    redirect_to admin_projects_path(by_category_id: params[:by_category_id])
  end

  def destroy
    begin
      flash[:notice] = "La référence a bien été supprimée" if @project.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      flash[:error] = "Cette référence ne peut être supprimée car des éléments lui sont dépendants"
    end
    redirect_to admin_projects_path
  end

  def get_picture_form
    render partial: "picture_form", locals: {idx: params[:idx]}
  end

  def sort_picture
    picture = @project.pictures.find(params[:picture_id])
    picture.insert_at(params[:position].to_i)
    render partial: "picture_list"
  end

  private

  def find_project
    @project = Project.from_param params[:id]
  end

  # strong parameters
  def project_params
    params.require(:project).permit(:category, :title, :slug, :description,
      :link, :deloyed_at, :seo_title, :seo_keywords, :seo_description,
      pictures_attributes: [:id, :alt, :title, :_destroy])
  end

end