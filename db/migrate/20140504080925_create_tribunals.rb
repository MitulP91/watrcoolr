class CreateTribunals < ActiveRecord::Migration
  def change
    create_table :tribunals do |t|
      t.integer :group_id
      t.integer :applicant_id
      t.integer :votes_for
      t.integer :votes_against
      t.integer :total_votes
      t.boolean :active
      t.timestamps
    end
  end
end
