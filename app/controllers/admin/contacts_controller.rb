class Admin::ContactsController < Admin::BaseController

  before_filter :find_contact, only: [ :edit, :update, :destroy ]

  def index
    params[:sort] ||= "sort_by_created_at desc"
    @contacts = Contact.apply_filters(params).paginate(per_page: 10, page: params[:page])
    # affichage flash message succès de modification du message d'accueil
    if session[:notice]
      flash[:notice] = session[:notice]
      session[:notice] = nil
    end
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

  # strong parameters
  def contact_params
    params.require(:contact).permit(:gender, :lastname, :firstname, :company, :email, :phone, :message)
  end

end
