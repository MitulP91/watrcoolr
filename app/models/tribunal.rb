class Tribunal < ActiveRecord::Base
	belongs_to :room

	has_and_belongs_to_many :users
	has_many :users_votes


end
