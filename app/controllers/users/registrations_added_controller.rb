# class RegistrationsAddedController < Devise::RegistrationsController

#   def create
#     super
#     if @user.persisted? || @user.save?
#       UserMailer.welcome_email(@user).deliver_now
#     end
#   end

# end
