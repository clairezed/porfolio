class Admin::ContactsController < Admin::BaseController

  before_filter :find_contact, only: [ :show, :destroy ]

  def index
    params[:sort] ||= "sort_by_created_at desc"
    @contacts = Contact.apply_filters(params).paginate(per_page: 10, page: params[:page])
    if session[:notice]
      flash[:notice] = session[:notice]
      session[:notice] = nil
    end
  end

  def show
    @contact.mark_as_read!
    render layout: false
  end

  def destroy
    @contact.destroy
    flash[:notice] = "Le contact a été supprimé avec succès"
    redirect_to admin_contacts_path
  end

  private

  def find_contact
    @contact = Contact.find params[:id]
  end

end
