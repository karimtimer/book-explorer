# frozen_string_literal: true

module ExternalService
  def make_external_post upload_url
    uri = URI.parse("https://enbrtwpe490a7.x.pipedream.net")
    request = Net::HTTP::Post.new(uri)
    request.set_form_data("s3_url" => upload_url)
    req_options = {use_ssl: uri.scheme == "https"}
    Net::HTTP.start(uri.hostname, uri.port, req_options) { |http| http.request(request) }
  end
end
