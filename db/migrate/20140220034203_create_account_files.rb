class CreateAccountFiles < ActiveRecord::Migration
  def change
    create_table :account_files do |t|
      t.string :name
      t.string :email_file
      t.timestamps
    end
    change_table :active_accounts do |t|
    	t.belongs_to :account_file
    end
  end
end
