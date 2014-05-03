class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :room

  self.inheritance_column = :type
end
