# frozen_string_literal: true

class AddOmniauthColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :text
    add_column :users, :oauth_token, :string
  end
end
