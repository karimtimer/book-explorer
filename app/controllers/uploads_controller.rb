class UploadsController < ApplicationController
  before_action :find_upload, except: %i[index new create]
  before_action :authenticate_user!

  def new; end

  def index
    @uploads = current_user.uploads
  end

  def show
    file_as_string = AmazonS3.new.receiver(@upload)
    @csv_table = CSV.parse(file_as_string, col_sep: ',', headers: true).map(&:to_h)
  end

  def create
    user_id = current_user.id
    message = Validator.new(params[:file]).validate_file
    return danger_and_redirect(message) unless message == 'uploading'

    upload = AmazonS3.new.uploader(params[:file], user_id)

    if upload.save
      uri = URI.parse('https://enbrtwpe490a7.x.pipedream.net')
      request = Net::HTTP::Post.new(uri)
      request.set_form_data('s3_url' => upload.url)
      req_options = { use_ssl: uri.scheme == 'https' }
      Net::HTTP.start(uri.hostname, uri.port, req_options) { |http| http.request(request) }

      redirect_to upload, success: 'File successfully uploaded'
    else
      flash.now[:notice] = 'There was an error'
      render :new
    end
  end

  def danger_and_redirect(message)
    redirect_to uploads_new_path, danger: message
  end

  private

  def find_upload
    @upload = Upload.find(params[:id])
  end
end
