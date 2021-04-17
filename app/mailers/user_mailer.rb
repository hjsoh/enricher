require 'sendgrid-ruby'
include SendGrid
require 'json'

class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #

  # default :from => 'any_from_address@example.com'

  def welcome_email(user)
    @user = user

    mail(to: @user.email, subject: 'Welcome to Enri\'cher')

    from = Email.new(email: 'enricher@enri-cher.com')
    subject = 'Welcome to Enri\'cher'
    to = Email.new(email: @user.email)
    content = Content.new(type: 'text/plain', value: 'Welcome to Enri\'cher')
    mail = SendGrid::Mail.new(from, subject, to, content)
    # puts JSON.pretty_generate(mail.to_json)
    puts mail.to_json

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
    # TODO: add some attachments
    #attachments.inline['image.jpg'] = File.read('/path/to/image.jpg')
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

  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for our amazing Enricher' )
  end


  # def new_welcome(email, row)
  #   @item = row

  #   mail(to: email, subject: 'Welcome to Enri\'cher')

  # end
end
