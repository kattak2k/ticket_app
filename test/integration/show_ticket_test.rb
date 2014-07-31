require 'test_helper'

class ShowTicketTest < ActionDispatch::IntegrationTest
  setup do
    @ticket = tickets(:one)
  end

  test 'show_ticket' do
    get "/api/tickets/#{@ticket.id}"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    ticket = json(response.body)[:ticket]
    assert_equal @ticket.id, ticket[:id]
    assert_equal @ticket.project_id, ticket[:project_id]
    assert_equal @ticket.subject, ticket[:subject]
    assert_equal @ticket.description, ticket[:description]
    assert_equal @ticket.priority, ticket[:priority]
    assert_equal @ticket.status, ticket[:status]
  end
end
