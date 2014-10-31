class AddAssociationToEmailAndActiveAccount < ActiveRecord::Migration
  def change
  	change_table :emails do|t|
  		t.belongs_to :active_account
  	end
  end
end
