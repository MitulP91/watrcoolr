class Room < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :messages
  has_many :tribunals

  delegate :texts, :videos, :images, to: :messages


end
