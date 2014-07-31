require 'test_helper'

class UpdateTicketTest < ActionDispatch::IntegrationTest
  setup do
    @ticket = tickets(:one)
  end

  test 'update ticket' do
    put "/api/tickets/#{@ticket.id}", {
      ticket: {
        subject: 'Bad robot.'
      }
    }.to_json,
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }

    assert_equal 204, response.status
    assert_equal 'Bad robot.', Ticket.find(@ticket.id).subject
  end
end
