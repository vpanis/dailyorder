class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user_id)
    @user = User.find(user_id)  # Instance variable => available in view

    mail(to: @user.email, subject: 'Welcome to DailyOrder')
    # This will render a view in `app/views/user_mailer`!
  end
end
