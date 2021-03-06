class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.boolean :self_destruct
      t.integer :self_destruct_time
      t.string :self_destruct_type
      t.string :type

      t.integer :room_id
      t.integer :user_id
      
      t.timestamps
    end
  end
end
