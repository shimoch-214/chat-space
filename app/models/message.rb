class Message < ApplicationRecord
  validates :body, presence: true, unless: :image?

  belongs_to :user
  belongs_to :group

  # mount_uploader :avatar, AvatarUploader

  def self.get_messages(group)
    if group.messages
      group.messages.order('created_at asc')
    else
      return false
    end
  end
end