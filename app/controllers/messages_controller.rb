class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

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
      redirect_to show_chat_path(@classroom, anchor: "message-#{@message.id}")
      #if we need anchor, anchor: "message-#{@message.id}"
    else
      render "classrooms/show"
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
