require 'test_helper'

class UpdateProjectTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:one)
  end

  test 'update project' do
    put "/api/projects/#{@project.id}", {
      project: {
        name: 'Mission Impossible'
      }
    }.to_json,
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }

    assert_equal 204, response.status
    assert_equal 'Mission Impossible', Project.find(@project.id).name
  end
end
