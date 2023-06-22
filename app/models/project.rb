class Project < ApplicationRecord
  has_many :comments

  enum :tracking_status, {
      draft: "draft",
      pending: "pending",
      in_progress: "in_progress",
      awaiting_information: "awaiting_information",
      awaiting_approval: "awaiting_approval",
      approved: "approved",
      overdue: "overdue",
      cancelled: "cancelled",
      completed: "completed"
    }, default: :draft

  validates :title, presence: true
  validates :tracking_status, presence: true
  validates :tracking_status, inclusion: {
    in: [
      "draft",
      "pending",
      "in_progress",
      "awaiting_information",
      "awaiting_approval",
      "approved",
      "overdue",
      "cancelled",
      "completed"
    ]
  }
end
