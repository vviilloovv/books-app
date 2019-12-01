# frozen_string_literal: true

class AddUserIdToBooks < ActiveRecord::Migration[6.0]
  def up
    execute "DELETE FROM books;"
    add_reference :books, :user, index: true, foreign_key: true
    change_column_null :books, :user_id, true
  end

  def down
    remove_reference :books, :user, index: true
  end
end
