class CreateFileLists < ActiveRecord::Migration
  def change
    create_table :file_lists do |t|
      t.string :disk
      t.string :filename

      t.timestamps
    end
  end
end
