# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
  def welcome_email
    UserMailer.welcome_email(User.last)
  end

  def welcome_email_reset_instructions
    UserMailer.welcome_email(User.last)
  end
end
