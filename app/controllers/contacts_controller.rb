class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: true
    else
      flash[:error] = "Oups, il y a eu un soucis lors de l'envoi de votre message"
      render json: false
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