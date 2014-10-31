class IncreasePnoneNumberSize < ActiveRecord::Migration
  def change
  	change_column :active_accounts,:phone,:string,:limit=>30
  	change_column :active_accounts,:age,:string,:limit=>30
    change_column :active_accounts,:gender,:string,:limit=>35
    change_column :active_accounts,:salary,:string,:limit=>35
  end
end
