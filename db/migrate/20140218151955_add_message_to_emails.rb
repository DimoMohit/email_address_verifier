class AddMessageToEmails < ActiveRecord::Migration
  def change
  	add_column :emails,:message,:string,:limit=>900
  end
end
