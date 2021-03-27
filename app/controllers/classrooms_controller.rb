class ClassroomsController < ApplicationController
  skip_after_action :verify_authorized

  def show
    @classroom = Classroom.find(params[:id])
    @message = Message.new
  end
end
