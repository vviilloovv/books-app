# frozen_string_literal: true

class RemovePictureFromBooks < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :picture, :string
  end
end
