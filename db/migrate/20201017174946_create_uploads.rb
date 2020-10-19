# frozen_string_literal: true

class CreateUploads < ActiveRecord::Migration[6.0]
  def change
    create_table :uploads do |t|
      t.string :url
      t.string :name

      t.timestamps
    end
  end
end
