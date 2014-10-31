class Broadcaster < ActionMailer::Base
  default from: "contact@ncds.in"
  def welcome_email(user,email)
    @user = user
    @email = email
    @url  = 'http://ncds.com'
    mail(to: @user.email, subject: @email.subject)
  end
end
