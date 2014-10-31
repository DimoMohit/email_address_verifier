class CreateActiveAccounts < ActiveRecord::Migration
  def change
    create_table :active_accounts do |t|
      t.string :name,:limit=>70
      t.string :email,:limit=> 90
      t.string :phone,:limit=>12
      t.integer :age,:limit=>3
      t.string :gender,:limit=>15
      t.string :salary,:limit=>15
      t.boolean :email_status
      t.integer :priority

      t.timestamps
    end
  end
end
