class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :room

  self.inheritance_column = :msg_type

  scope :texts, -> { where(msg_type: 'Text') } 
  scope :videos, -> { where(msg_type: 'Video') } 
  scope :images, -> { where(msg_type: 'Image') }
end

class Text < Message
end

class Video < Message
end

class Image < Message
end