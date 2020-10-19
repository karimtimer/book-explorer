# frozen_string_literal: true

# app/models/model.rb
class Model < ApplicationRecord
  mount_uploader :file, ModelUploader
end
