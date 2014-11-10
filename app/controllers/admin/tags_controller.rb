class Admin::TagsController < Admin::BaseController

  def check
    tag = Tag.where(title: params[:tag_title]).first_or_create
    # raise params[:project_id].inspect
    project = Project.find params[:project_id]
    project.project_tags.create(tag_id: tag.id)
    # raise project.inspect
  end

end