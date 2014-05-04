class RenameUsersVotes < ActiveRecord::Migration
  def change
  	rename_table :users_votes_tables, :users_votes
  end
end
