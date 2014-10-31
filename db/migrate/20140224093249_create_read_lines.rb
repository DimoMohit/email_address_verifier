class CreateReadLines < ActiveRecord::Migration
  def change
    create_table :read_lines do |t|
      t.belongs_to :account_file
      t.integer :lines_read,:limit=>11
      t.timestamps
    end
  end
end
