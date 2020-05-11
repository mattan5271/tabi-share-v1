class User::RemindMailer < ApplicationMailer
    def remind_mail(user)
        @user = user
        mail from: "matsubishi5@gmail.com", to: @user.email, subject: "リマインドメール"
    end

    def self.send_when_unchecked_notification
        users = User.all
        users.each do |user|
          if ApplicationController.helpers.unchecked_notifications(user).present?
            User::RemindMailer.remind_mail(user).deliver
          end
        end
    end
end
