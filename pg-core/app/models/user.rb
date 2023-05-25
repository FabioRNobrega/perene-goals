# frozen_string_literal: true

class User < ActiveRecord::Base
  include Sortable
  include DeviseTokenAuth::Concerns::User

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :trackable,
         :confirmable

  has_many :goals_list, dependent: :destroy

  validate :password_fields_present, if: -> { name.blank? }
  validate :password_fields_match, if: -> { name.blank? }

  private

  def password_fields_present
    errors.add(:password, "can't be blank") if password.blank?
    errors.add(:password_confirmation, "can't be blank") if password_confirmation.blank?
  end

  def password_fields_match
    errors.add(:password_confirmation, "doesn't match Password") if password != password_confirmation
  end
end
