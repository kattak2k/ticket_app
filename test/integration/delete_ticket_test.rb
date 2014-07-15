require 'test_helper'

class DeleteTicketTest < ActionDispatch::IntegrationTest
  setup do
    @project = Project.create!(name: 'Test Project')
    @ticket = @project.tickets.create(subject: 'Test Issue', description: 'This is a test.')
  end

  test 'delete project' do
    delete "/api/projects/#{@project.id}/tickets/#{@ticket.id}"
    assert_equal 204, response.status
  end
end
