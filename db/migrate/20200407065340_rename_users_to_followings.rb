# frozen_string_literal: true

class RenameUsersToFollowings < ActiveRecord::Migration[6.0]
  def change
    rename_table :relationships, :followings
  end
end
