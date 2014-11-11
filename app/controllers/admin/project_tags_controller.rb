class Admin::ProjectTagsController < Admin::BaseController

  before_filter :check_referer_host, only: [:destroy]

  respond_to :json, only: [:destroy]


  def destroy
    @project_tag = ProjectTag.find params[:id]
    # raise @project_tag.inspect
    if @project_tag.destroy
      flash[:notice] = "Le tag a bien été supprimé"
    else
      flash[:error] = "Une erreur s'est produite lors de la suppression du tag"
    end
    render nothing: true
  end

end