class CommentsController < ApplicationController
  include Pundit

  def new
    @ticket = Ticket.find(params[:ticket_id])
    @comment = Comment.new
    authorize @comment
    authorize @ticket
  end

  def create
    @comment = Comment.new(comment_params)

    @ticket = Ticket.find(params[:ticket_id])
    authorize @comment
    authorize @ticket
    @comment.ticket = @ticket
    @comment.author_id = current_user.id
    @comment.save
    redirect_to ticket_path(@ticket)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
