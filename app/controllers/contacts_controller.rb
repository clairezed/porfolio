class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    # raise params.inspect
    @contact = Contact.new(contact_params)
    if @contact.save
      render partial: "contacts/contact_success"
    else
      flash[:error] = "Oups, il y a eu un soucis lors de l'envoi de votre message"
      render partial: "contacts/contact_form", locals: {contact: @contact}
    end
  end

  def index
  end

  private

  # strong parameters
  def contact_params
    params.require(:contact).permit(:email, :subject, :message)
  end

end