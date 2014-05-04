class ChangeApplicantIdToUserId < ActiveRecord::Migration
  def change
  	rename_column :tribunals, :applicant_id, :user_id
  end
end
