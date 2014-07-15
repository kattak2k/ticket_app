class TicketSerializer < ActiveModel::Serializer
  attributes :id, :project_id, :subject, :description, :priority, :status

  has_many :comments
end
