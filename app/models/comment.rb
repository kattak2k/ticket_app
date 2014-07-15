class Comment < ActiveRecord::Base
  belongs_to :ticket

  validates :ticket_id, presence: true
  validates :content, presence: true
end
