class AnnouncementsController < ApplicationController
  include Pundit

  def index
    @announcement = policy_scope(Announcement).order(created_at: :desc)
  end

  def new
    @classroom = Classroom.find(params[:classroom_id])
    @announcement = Announcement.new
    authorize @announcement
    authorize @classroom
  end

  def create
    @announcement = Announcement.new(announcement_params)
    @classroom = Classroom.find(params[:classroom_id])

    @announcement.user = current_user
    @announcement.classroom = @classroom

    authorize @announcement

    if @announcement.save
      redirect_to classroom_announcements_path(@classroom)
    else
      render :new
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
    params.require(:announcement).permit(:title, :content)
  end
end
