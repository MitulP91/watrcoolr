class User < ActiveRecord::Base
  has_and_belongs_to_many :rooms
  has_many :messages
  has_and_belongs_to_many :tribunals

  delegate :texts, :videos, :images, to: :messages

  validates_uniqueness_of :username

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :users_votes
end

class Applicant < User
end

class Voter < User
end
