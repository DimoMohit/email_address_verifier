class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :subject,:limit=>100
      t.string :files

      t.timestamps
    end
  end
end
