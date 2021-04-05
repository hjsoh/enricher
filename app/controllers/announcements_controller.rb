class AnnouncementsController < ApplicationController
  include Pundit

  def index
    @announcements = policy_scope(Announcement).order(created_at: :desc)
    @announcement = Announcement.new
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
    @announcement.destroy
    redirect_to announcements_path
  end

  private

  def announcement_params
    params.require(:announcement).permit(:title, :content, classroom_ids: [])
  end
end
