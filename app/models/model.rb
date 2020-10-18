# app/models/model.rb
class Model < ActiveRecord::Base
  mount_uploader :file, ModelUploader
end
