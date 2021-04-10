# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
  def welcome_email
    # @users = User.all
    # This is how you pass value to params[:user] inside mailer definition!

    # row = 'row'
    # UserMailer.with(user: User.last).welcome_email(row)

    UserMailer.welcome_email(User.last).deliver_now
    #UserMailer.with(email: 'wzhikai@gmail.com').welcome_email
  end

end
