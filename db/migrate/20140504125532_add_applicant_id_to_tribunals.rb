class AddApplicantIdToTribunals < ActiveRecord::Migration
  def change
  	add_column :tribunals, :applicant_id, :integer
  end
end
