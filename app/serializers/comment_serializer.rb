class CommentSerializer < ActiveModel::Serializer
  attributes :id, :ticket_id, :name, :body, :created_at
end
