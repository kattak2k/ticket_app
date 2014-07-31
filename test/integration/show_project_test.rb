require 'test_helper'

class ShowProjectTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:one)
  end

  test 'show_project' do
    get "/api/projects/#{@project.id}"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    project = json(response.body)[:project]
    assert_equal @project.id, project[:id]
    assert_equal @project.name, project[:name]
  end
end
