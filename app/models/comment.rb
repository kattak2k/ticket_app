class Comment < ActiveRecord::Base
  belongs_to :ticket

  validates :ticket_id, presence: true
  validates :name, presence: true
  validates :body, presence: true
end
