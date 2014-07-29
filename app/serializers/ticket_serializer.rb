class TicketSerializer < ActiveModel::Serializer
  attributes :id, :project_id, :subject, :description, :priority, :status, :created_at

  embed :ids
  has_many :comments
end
