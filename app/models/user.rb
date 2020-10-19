# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validate :validate_username

  has_many :uploads, dependent: :destroy

  attr_writer :login

  def login
    @login || username || email
  end

  # rubocop:disable Lint/AssignmentInCondition
  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).find_by(["lower(username) = :value OR lower(email) = :value", {value: login.downcase}])
    elsif conditions.key?(:username) || conditions.key?(:email)
      conditions[:email]&.downcase!
      find_by(conditions.to_h)
    end
  end
  # rubocop:enable Lint/AssignmentInCondition

  def validate_username
    errors.add(:username, :invalid) if User.exists?(email: username)
  end
end
