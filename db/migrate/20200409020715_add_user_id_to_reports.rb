# frozen_string_literal: true

class AddUserIdToReports < ActiveRecord::Migration[6.0]
  def change
    add_reference :reports, :user, index: true, foreign_key: true
    change_column_null :reports, :user_id, true
  end
end
