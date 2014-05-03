class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :description
      t.boolean :private
      t.boolean :message_scrub
      t.string :voting
      t.boolean :mms
      t.timestamp :last_post

      t.timestamps
    end
  end
end
