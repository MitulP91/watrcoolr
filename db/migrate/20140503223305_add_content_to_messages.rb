class AddContentToMessages < ActiveRecord::Migration
  def change
  	change_table :messages do |t|
  		t.text :msg_content
  	end
  end
end
