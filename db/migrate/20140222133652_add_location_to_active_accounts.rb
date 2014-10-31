class AddLocationToActiveAccounts < ActiveRecord::Migration
  def change
  	add_column :active_accounts,:location,:string,:limit=>120
  end
end
