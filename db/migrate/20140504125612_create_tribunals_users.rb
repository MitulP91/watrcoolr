class CreateTribunalsUsers < ActiveRecord::Migration
  def change
    create_table :tribunals_users do |t|
    	t.integer :tribunal_id
    	t.integer :user_id
    end
  end
end
