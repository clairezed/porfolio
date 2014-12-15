class Admin::ProjectTagsController < Admin::BaseController

  before_filter :check_referer_host, only: [:destroy]
  before_filter :find_project, only: [:create]

  def create
    @project_tag = ProjectTag.initialize_from_project(params.permit(:title, :project_id))
    unless @project_tag.save
      flash[:error] = "Une erreur s'est produite lors de la création du tag"
    end
    render partial: "admin/projects/tags_list", locals: {project_tags: @project.project_tags}
  end

  def destroy
    project_tag = ProjectTag.find params[:id]
    project = project_tag.project
    unless project_tag.destroy
      flash[:error] = "Une erreur s'est produite lors de la suppression du tag"
    end
    render partial: "admin/projects/tags_list", locals: {project_tags: project.project_tags}
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

end