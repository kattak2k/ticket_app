require 'test_helper'

class CreateProjectsTest < ActionDispatch::IntegrationTest
  test 'create project with valid data' do
    post '/api/projects', {
      project: {
        name: 'Project One'
      }
    }.to_json,
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type

    project = json(response.body)[:project]
    assert_equal api_project_url(project[:id]), response.location
    assert_equal 'Project One', project[:name]
  end

  test 'do not create project with invalid data' do
    post '/api/projects', {
      project: {
        name: nil
      }
    }.to_json,
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
