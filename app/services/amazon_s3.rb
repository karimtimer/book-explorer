# frozen_string_literal: true

require "uuid"

class AmazonS3
  attr_reader :s3

  def initialize
    @s3 = set_resource
  end

  def uploader filename, user_id
    local_file_name = File.basename(filename.original_filename)
    aws_file_name = generate_uniq_name(local_file_name)
    obj = @s3.bucket("karimtimer-book-explorer").object(aws_file_name)

    obj.upload_file(filename)

    Upload.new(
      url: obj.public_url,
      name: local_file_name,
      aws_filename: aws_file_name,
      user_id: user_id
    )
  end

  def receiver upload_obj
    bucket = @s3.bucket("karimtimer-book-explorer")
    bucket.object(upload_obj.aws_filename).get.body.string
  end

  private

  def set_resource
    access_key_id = Rails.application.credentials.aws[:access_key_id]
    secret_access_key = Rails.application.credentials.aws[:secret_access_key]

    Aws::S3::Resource.new(access_key_id: access_key_id,
                          secret_access_key: secret_access_key,
                          region: "eu-west-2")
  end

  def generate_uniq_name name
    uuid = UUID.new
    name + uuid.generate.to_s
  end
end
