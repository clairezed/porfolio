class Admin::TagsController < Admin::BaseController

  def check
    tag = Tag.where(title: params[:tag_title]).first_or_create
    # raise params[:project_id].inspect
    project = Project.find params[:project_id]
    if project.project_tags.create(tag_id: tag.id)
      render partial: "admin/projects/tags_list", locals: {tags: project.tags}
    else
      flash[:error] = "Une erreur s'est produite lors de la création du projet"
      render nothing: true
    end
  end

end