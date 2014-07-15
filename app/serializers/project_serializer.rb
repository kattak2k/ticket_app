class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name

  embed :ids
  has_many :tickets
end
