class UserGroup < ApplicationRecord
  belongs_to  :user
  belongs_to  :group
  # validates   :user_id, uniqueness: {scope: :group_id}
  # validates   :group_id, uniqueness: {scope: :user_id}
end
