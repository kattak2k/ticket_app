require 'test_helper'

class UpdateTicketTest < ActionDispatch::IntegrationTest
  setup do
    project = Project.create!(name: 'Project One')
    @ticket = project.tickets.create!(subject: 'Test Issue', description: 'This is a test.')
  end

  test 'update ticket' do
    put "/api/tickets/#{@ticket.id}", {
      ticket: {
        subject: 'Bad data'
      }
    }.to_json,
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }

    assert_equal 204, response.status
    assert_equal 'Bad data', Ticket.find(@ticket.id).subject
  end
end
