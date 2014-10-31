class AddFromInMails < ActiveRecord::Migration
  def change
  	add_column :emails,:from,:string,:limit=>70
  end
end
