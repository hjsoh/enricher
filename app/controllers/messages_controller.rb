class MessagesController < ApplicationController
  
  def create
    @classroom = Classroom.find(params[:classroom_id])
    @message = Message.new(message_params)
    @message.classroom = @classroom
    @message.user = current_user
    authorize(@message)

    if @message.save
      ClassroomChannel.broadcast_to(
        @classroom,
        render_to_string(partial: "message", locals: { message: @message })
      )
      redirect_to classroom_path(@classroom, anchor: "message-#{@message.id}")
    else
      render "classrooms/show"
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
