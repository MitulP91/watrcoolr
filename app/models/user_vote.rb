class UserVote < ActiveRecord::Base
	belongs_to :user
	belongs_to :tribunal
end