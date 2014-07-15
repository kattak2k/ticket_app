class Api::TicketsController < Api::BaseController
  def index
    tickets = Ticket.where(project_id: params[:project_id])
    respond_with tickets
  end

  def create
    ticket = Ticket.create(ticket_params)
    respond_with :api, ticket
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    respond_with @ticket.destroy
  end

  def ticket_params
    params.require(:ticket).permit(:project_id, :subject, :description, :priority, :status)
  end
end
