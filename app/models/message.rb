class Message < ApplicationRecord
  validates :body, presence: true, unless: :image?
  mount_uploader :image, ImageUploader, if: :image?

  belongs_to :user
  belongs_to :group


  def self.get_sorted_messages(group)
    if group.messages.length > 0
      group.messages.order('created_at asc')
    else
      return false
    end
  end
end