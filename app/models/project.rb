class Project < ApplicationRecord
  enum status: {
      draft: 0,
      pending: 10,
      in_progress: 20,
      awaiting_information: 30,
      awaiting_approval: 40,
      approved: 50,
      overdue: 60,
      cancelled: 70,
      completed: 80
    }

  validates :title, presence: true
  validates :status, presence: true
end
