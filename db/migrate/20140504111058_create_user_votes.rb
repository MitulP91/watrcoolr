class CreateUserVotes < ActiveRecord::Migration
  def change
    create_table :user_votes do |t|

      t.timestamps
    end
  end
end
