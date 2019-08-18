class EditColumnsInMessages < ActiveRecord::Migration[5.0]
  def change
    change_column_null :messages, :body, true
    change_column_null :messages, :image, true
  end
end
