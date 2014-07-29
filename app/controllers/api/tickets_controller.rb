class Api::TicketsController < Api::BaseController
  def index
    if project_id = params[:project_id]
      tickets = Ticket.where(project_id: project_id)
    elsif ids = params[:ids]
      tickets = Ticket.find(ids)
    else
      tickets = Ticket.all
    end
    respond_with tickets
  end

  def show
    ticket = Ticket.find(params[:id])
    respond_with ticket
  end

  def create
    ticket = Ticket.create(ticket_params)
    respond_with :api, ticket
  end

  def update
    ticket = Ticket.find(params[:id])
    ticket.update(ticket_params)
    respond_with ticket
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    respond_with @ticket.destroy
  end

  def ticket_params
    params.require(:ticket).permit(:project_id, :subject, :description, :priority, :status)
  end
end
