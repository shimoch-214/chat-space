class ChangeColumnsInMessages < ActiveRecord::Migration[5.0]
  def change
    change_column_null :messages, :body, false
    change_column_null :messages, :image, false
  end
end
