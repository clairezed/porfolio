class Admin::TagsController < Admin::BaseController

  before_filter :check_referer_host, only: [:autocomplete]

  respond_to :json, only: [:autocomplete]

  def index
    params[:sort] ||= "sort_by_created_at desc"
    @tags = Tag.apply_filters(params).paginate(per_page: 10, page: params[:page])
  end

  def autocomplete
    result = params[:val].blank? ? [] : Tag.by_title(params[:val].to_s)
    respond_with result
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