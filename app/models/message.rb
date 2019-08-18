class Message < ApplicationRecord
  validates :body, presence: true, unless: :image?

  belongs_to :user
  belongs_to :group
end
