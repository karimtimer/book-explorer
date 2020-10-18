class AddForeignKeyToUpload < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :uploads, :users
  end
end
