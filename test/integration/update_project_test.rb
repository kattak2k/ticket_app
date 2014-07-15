require 'test_helper'

class UpdateProjectTest < ActionDispatch::IntegrationTest
  setup do
    @project = Project.create!(name: 'Project One')
  end

  test 'update project' do
    put "/api/projects/#{@project.id}", {
      project: {
        name: 'Project 1'
      }
    }.to_json,
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }

    assert_equal 204, response.status
    assert_equal 'Project 1', Project.find(@project.id).name
  end
end
