class AdminMailer < ActionMailer::Base

  default from: SYSTEM_MAILER,
          to:   DEFAULT_RECIPIENT

  # ===== Contacts ==================================================

  def new_contact(contact)
    @contact = contact
    mail from: @contact.email,
      subject: "[Clairezed portfolio] #{@contact.subject}"
  end

end