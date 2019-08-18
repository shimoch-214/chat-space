class Group < ApplicationRecord
  validates :name, presence: true
  validate  :ja_error_messages

  has_many  :user_groups
  has_many  :users, through: :user_groups
  has_many  :messages

  def ja_error_messages
    if name.blank?
      errors[:adding] = "グループ名は必須です。"
      errors.messages.delete(:name)
    end
  end
end
