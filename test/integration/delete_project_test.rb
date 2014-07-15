require 'test_helper'

class DeleteProjectTest < ActionDispatch::IntegrationTest
  setup do
    @project = Project.create!(name: 'Test Project')
  end

  test 'delete project' do
    delete "/api/projects/#{@project.id}"
    assert_equal 204, response.status
  end
end
