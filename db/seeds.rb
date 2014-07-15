['Project One', 'Project Two'].each do |name|
  project = Project.find_or_create_by(name: name)
  project.tickets.find_or_create_by(subject: 'Test Issue', description: 'This is a test.')
end
