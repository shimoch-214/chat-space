class Message < ApplicationRecord
  validates :body, presence: true, unless: :image?
  mount_uploader :image, ImageUploader, if: :image?

  belongs_to :user
  belongs_to :group


  # def self.get_sorted_messages(group)
  #   group.messages.order('created_at asc')
  # end
end