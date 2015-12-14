class UserMailer < ActionMailer::Base
  default from: "david.w.christian@gmail.com"

  def password_reset(user)
    @user = user
    @domain = get_domain
    mail to: user.email, subject: "Password Reset Instructions - Display AdTech"
  end
  
  def get_domain
    return 'http://localhost:4200' if Rails.env.development?
    return 'http://production-site.com' if Rails.env.production?
  end
end