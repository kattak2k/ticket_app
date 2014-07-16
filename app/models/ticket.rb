class Ticket < ActiveRecord::Base
  belongs_to :project
  has_many   :comments

  validates :project_id, presence: true
  validates :subject, presence: true
  validates :description, presence: true

  enum priority: [:low, :medium, :high]
  enum status: [:open, :in_progress, :ready_for_review, :resolved, :closed]
end
