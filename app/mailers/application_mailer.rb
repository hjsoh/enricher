class ApplicationMailer < ActionMailer::Base
  default from: 'enricher@enricher.com'
  layout 'mailer'
end



  # send a signup email to the user, pass in the user object that   contains the user's email address
