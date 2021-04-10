class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome_email(user)
    @user = user


    mail(to: @user.email, subject: 'Welcome to Enri\'cher')
  end
    # emails = ['wzhikai@gmail.com']
    # # @users = ['wzhikai@gmail.com'] # Instance variable => available in view
    # # @users.each do |user|
    # emails.each do |email|
    #   new_welcome(email,row).deliver_now
    # end
      # mail(to: 'wzhikai@gmail.com', subject: 'Welcome to Enri\'cher')
      # raise
    # This will render a view in `app/views/user_mailer`!
    # end



  # def new_welcome(email, row)
  #   @item = row

  #   mail(to: email, subject: 'Welcome to Enri\'cher')

  # end
end
