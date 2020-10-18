require 'csv'
require 'set'
require 'isbn'
class Validator

  def initialize file_param
    @filename = file_param&.tempfile&.path
    @isbn_arr = []
  end

  def validate_file sep: ',', columns: 5
    return "No File" unless @filename
    return "No File" unless File.exist?(@filename)

    content = File.read(@filename, :encoding => 'utf-8')
    return "Wrong encoding" unless content.valid_encoding? #"Wrong encoding" 

    content.each_line{|line|
      return "Wrong number of columns" if line.count(sep) < columns - 1

      isbn = line.split(sep)[3].to_s
      debugger
      ISBN.valid?(isbn)
      @isbn_arr << isbn
    }
    isbn ? error_message(isbn) : "uploading"
  end

  def isbn
    s = Set.new
    duplicate = @isbn_arr.find { |e| !s.add?(e) }
    duplicate
  end

  def error_message isbn
    "ISBN: #{isbn} should not appear more than once in the csv."
  end
end
