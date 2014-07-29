['Project One', 'Project Two'].each do |name|
  project = Project.find_or_create_by(name: name)
  project.tickets.find_or_create_by(subject: 'Test Issue', description: 'This is a test.')
  project.tickets.first.comments.find_or_create_by(name: 'Sam', body: 'Are you sure this is a bug?')
end
