class ApplicationController < ActionController::Base
  include Pundit

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  attr_accessor :allow_blank_password

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up)
    devise_parameter_sanitizer.permit(:account_update, keys: [:photo])
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def get_announcements(user)
    @user = user
    @announcements = @user.announcements.order(created_at: :desc)
    @classrooms = @user.classrooms
    @classroom_announcements = []
    @classrooms.each do |classroom|
      if !classroom.classroom_announcements.empty?
        @classroom_announcements << classroom.classroom_announcements
      end
    end
    @filtered_announcements = @classroom_announcements.flatten

    @unread_announcements = @filtered_announcements.reject{ |announcement| announcement.created_at <= @user.last_sign_in_at }
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
