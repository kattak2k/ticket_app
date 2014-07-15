class CommentSerializer < ActiveModel::Serializer
  attributes :id, :ticket_id, :content
end
