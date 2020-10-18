class AddUserToUploads < ActiveRecord::Migration[6.0]
  def change
    add_reference :uploads, :user
  end
end
