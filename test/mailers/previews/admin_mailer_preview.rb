class AdminMailerPreview < ActionMailer::Preview

  # http://localhost:3000/rails/mailers/admin_mailer/new_contact
  def new_contact
    contact = Contact.last
    AdminMailer.new_contact(contact)
  end
end