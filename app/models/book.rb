# frozen_string_literal: true

class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  paginates_per 7
  has_many :comments, as: :commentable, dependent: :destroy
end
