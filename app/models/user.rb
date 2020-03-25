# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :postal_code, format: { with: /\A\d{7}\z/, message: "は半角数字7桁を入力してください" },
    unless: -> { postal_code.blank? }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :icon
  has_many :books
  paginates_per 7

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i(github)

  def follow(user)
    unless self == user
      self.relationships.find_or_create_by(follow_id: user.id)
    end
  end

  def unfollow(user)
    relationship = self.relationships.find_by(follow_id: user.id)
    relationship.destroy if relationship
  end

  def following?(user)
    self.followings.include?(user)
  end

  def self.from_omniauth(auth)
    user = User.find_by(email: auth.info.email)
    if user
      user.provider = auth.provider
      user.uid = auth.uid
      user.save
    else
      user = User.where(provider: auth.provider, uid: auth.uid).first_or_create do |usr|
        usr.email = auth.info.email
        usr.name = auth.info.name
        usr.password = Devise.friendly_token[0, 20]
      end
    end
    user
  end

  def self.create_unique_string
    SecureRandom.uuid
  end
end
