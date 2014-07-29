require 'test_helper'

class ListingTicketsTest < ActionDispatch::IntegrationTest
  setup do
    @project = Project.create!(name: 'Project One')
    @project.tickets.create!(subject: 'Test Issue', description: 'This is a test.', priority: 'low', status: 'open')
  end

  test 'listing_tickets' do
    get "/api/tickets?project_id=#{@project.id}"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal @project.tickets.count, json(response.body)[:tickets].size
  end
end
