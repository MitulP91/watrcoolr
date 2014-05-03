class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :room

  self.inheritance_column = :type

  scope :texts, -> { where(type: 'Text') } 
  scope :videos, -> { where(type: 'Video') } 
  scope :images, -> { where(type: 'Image') }
end

class Text < Message
end

class Video < Message
end

class Image < Message
end