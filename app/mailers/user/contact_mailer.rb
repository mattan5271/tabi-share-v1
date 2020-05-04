class User::ContactMailer < ApplicationMailer

  def contact_mail(contact)
    @contact = contact
    mail from: contact.email, to: 'matsubishi5@gmail.com', subject: contact.title
  end
end
