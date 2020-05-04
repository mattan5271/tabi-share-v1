# Preview all emails at http://localhost:3000/rails/mailers/user/contact_mailer
class User::ContactMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user/contact_mailer/contact_mail
  def contact_mail
    User::ContactMailer.contact_mail
  end

end
