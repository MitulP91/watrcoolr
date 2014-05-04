class Tribunal < ActiveRecord::Base
	belongs_to :room
	belongs_to :user

	has_many :users_votes

end
