require 'test_helper'

class ListingTicketsTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:one)
  end

  test 'listing all tickets' do
    get "/api/tickets"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal Ticket.count, json(response.body)[:tickets].size
  end

  test 'listing tickets by project' do
    get "/api/tickets?project_id=#{@project.id}"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal @project.tickets.count, json(response.body)[:tickets].size
  end

  test 'listing tickets by ids' do
    ids = @project.tickets.pluck(:id)
    get "/api/tickets?ids[]=#{ids.join('&ids[]=')}"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal ids.count, json(response.body)[:tickets].size
  end
end
