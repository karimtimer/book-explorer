# frozen_string_literal: true

class AddAwsFilenameToUploads < ActiveRecord::Migration[6.0]
  def change
    add_column :uploads, :aws_filename, :string
  end
end
