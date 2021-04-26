class AnnouncementsController < ApplicationController
  include Pundit

  def index
    session[:just_created_announcements] = false if URI(request.referer).path != "/announcements"
    binding.pry
    @announcement = Announcement.new
    unless session[:just_created_announcements] == true
      current_user.last_sign_in_at = Time.now
      current_user.save
    end
    if params[:search].present?
      @announcements = policy_scope(Announcement).order(created_at: :desc).search_by_title_and_contents(params[:search])
    else
      @announcements = policy_scope(Announcement).order(created_at: :desc)
    end
  end

  def new
    @announcement = Announcement.new
    authorize @announcement
  end

  def create
    @announcement = Announcement.new(announcement_params)
    @classroom_ids = announcement_params[:classroom_ids]

    authorize @announcement
    if @announcement.save
      session[:just_created_announcements] = true
      redirect_to announcements_path
    else
      redirect_to announcements_path
      flash[:alert] = "Please include a title."
    end
  end

  def show
    @announcement = Announcement.find(params[:id])
    authorize @announcement
  end

  def destroy
    @announcement = Announcement.find(params[:id])
    authorize @announcement
    @announcement.destroy
    redirect_to announcements_path
  end

  private

  def announcement_params
    params.require(:announcement).permit(:title, :content, classroom_ids: [])
  end

end
