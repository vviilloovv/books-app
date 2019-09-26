# frozen_string_literal: true

class ChangeDatatypePostalCodeOfUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :postal_code, :string
  end
end
