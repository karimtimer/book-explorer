# frozen_string_literal: true

require "csv"
require "set"
require "isbn"
class Validator
  CSV_HEADERS = "Book Title,Book Author,Date published,ISBN,publishers name"

  def initialize file_param
    @filename = file_param&.tempfile&.path
    @isbn_arr = []
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength
  def validate_file sep: ",", columns: 5
    return "No File" unless @filename
    return "No File" unless File.exist?(@filename)

    headers, body = File.read(@filename, encoding: "utf-8").split("\n", 2)
    return "Wrong header names" unless valid_headers?(headers)
    return "Wrong encoding" unless body.valid_encoding? # "Wrong encoding"

    body.each_line do |line|
      next if line == ",,,,"
      return "Wrong number of columns" if line.count(sep) < columns - 1

      isbn = line.split(sep)[3].to_s
      return "ISBN: #{isbn} is not valid." unless ISBN.valid?(isbn)

      @isbn_arr << isbn
    end
    "uploading"
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/MethodLength

  def valid_headers? headers
    headers.include?(CSV_HEADERS)
  end
end
