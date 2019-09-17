# frozen_string_literal: true

class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false, default: "名無しさん"
    add_column :users, :postal_code, :integer
    add_column :users, :address, :string
    add_column :users, :profile, :text
  end
end
