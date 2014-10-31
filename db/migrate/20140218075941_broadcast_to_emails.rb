class BroadcastToEmails < ActiveRecord::Migration
  def change
  	add_column :emails,:broadcasted,:boolean
  end
end
