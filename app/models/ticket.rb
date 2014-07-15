class Ticket < ActiveRecord::Base
  belongs_to :project
  has_many   :comments

  validates :project_id, presence: true
  validates :subject, presence: true
  validates :description, presence: true
end
