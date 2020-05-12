class User::ContactMailer < ApplicationMailer

  def contact_mail(contact)
    @contact = contact
    mail from: contact.email, to: ENV['GMAIL_ADDRESS'], subject: contact.title
  end
end
