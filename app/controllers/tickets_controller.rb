class TicketsController < ApplicationController
  include Pundit

  def index
    @tickets = policy_scope(Ticket).order(created_at: :desc)
  end

  def new
    @classroom = Classroom.find(params[:classroom_id])
    @ticket = Ticket.new
    authorize @ticket
    authorize @classroom
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @classroom = Classroom.find(params[:classroom_id])

    @ticket.is_private = true
    @ticket.status = "open"
    @ticket.user = current_user
    @ticket.classroom = @classroom

    authorize @ticket
    authorize @classroom


    #need one for teacher, one for parent. doing for parent now
    @ticket.save
    redirect_to classroom_tickets_path(@classroom)
  end

  def show
    @ticket = Ticket.find(params[:id])
    authorize @ticket
  end

  def done
    @ticket = Ticket.find(params[:id])
    authorize @ticket

    @ticket.update(ticket_params)

    redirect_to ticket_path(@ticket)
  end

  private

  def ticket_params
    params.require(:ticket).permit(:question, :academic_year, :user_id, :classroom_id, :category_name, :is_private, :status)
  end
end
