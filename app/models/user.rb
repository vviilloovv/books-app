# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :postal_code, format: { with: /\A\d{7}\z/, message: "は半角数字7桁を入力してください" }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
