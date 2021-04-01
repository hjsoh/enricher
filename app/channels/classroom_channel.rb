class ClassroomChannel < ApplicationCable::Channel
  def subscribed
    classroom = Classroom.find(params[:id])
    stream_for classroom
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
