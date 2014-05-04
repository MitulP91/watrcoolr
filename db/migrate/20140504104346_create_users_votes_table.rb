class CreateUsersVotesTable < ActiveRecord::Migration
  def change
    create_table :users_votes_tables do |t|
    	t.integer :user_id
    	t.integer :tribunal_id
    	t.boolean :has_voted
    	t.timestamps
    end
  end
end
