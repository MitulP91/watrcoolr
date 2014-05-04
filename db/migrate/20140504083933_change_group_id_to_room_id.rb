class ChangeGroupIdToRoomId < ActiveRecord::Migration
  def change
  	rename_column :tribunals, :group_id, :room_id
  end
end
