class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user_id)
    @user = User.where(id: user_id).first
    @greeting = "Hi #{@user.first_name}"

    mail to: @user.email, :subject => 'Welcome to OfferUp!'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.friend_added.subject
  #
  def friend_added(current_user, friendee)
    @greeting = "Hi #{friendee.first_name}"
    @friender = current_user.first_name
    mail to: friendee.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.forgot_password.subject
  #
  def forgot_password(user)
    @user = user
    @greeting = "Hi"

    mail to: user.email, :subject => 'Reset password instructions'
  end
end
