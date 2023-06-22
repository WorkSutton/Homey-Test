class Comment < ApplicationRecord
  belongs_to :project

  validates :detail, presence: true
end
