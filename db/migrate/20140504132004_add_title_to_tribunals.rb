class AddTitleToTribunals < ActiveRecord::Migration
  def change
  	add_column :tribunals, :title, :string
  end
end
