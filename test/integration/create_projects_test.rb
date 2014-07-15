require 'test_helper'

class CreateProjectsTest < ActionDispatch::IntegrationTest
  test 'create project with valid data' do
    post '/projects', { project: {
      name: 'Test Project'
    } }.to_json,
    {'Accept' => 'application/json',
     'Content-Type' => 'application/json' }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type

    project = json(response.body)
    assert_equal project_url(project[:id]), response.location
    assert_equal 'Test Project', project[:name]
  end

  test 'do not create project with invalid data' do
    post '/projects', { project: {
      name: nil
    } }.to_json,
    {'Accept' => 'application/json',
     'Content-Type' => 'application/json' }

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
