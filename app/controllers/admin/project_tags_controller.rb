class Admin::ProjectTagsController < Admin::BaseController

  before_filter :check_referer_host, only: [:destroy]


  def destroy
    project_tag = ProjectTag.find params[:id]
    project = project_tag.project
    if project_tag.destroy
      render partial: "admin/projects/tags_list", locals: {project_tags: project.project_tags}
    else
      flash[:error] = "Une erreur s'est produite lors de la suppression du tag"
      render nothing: true
    end
  end
end