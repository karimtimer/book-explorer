class CSVProcessor
  def process_file file, options = {}
    csv_array = File.readlines(file.to_s)
    csv_array.shift(options[:skip_lines]) if options[:skip_lines]
    string = csv_array.map { |d| Iconv.new("UTF-8", "LATIN1").iconv(d) }.join
    process_string(string)
  end

  def process_string string
    CSV.parse(string, headers: true, encoding: "ISO-8859-1", header_converters: :symbol, converters: [->(v) { v&.strip }])
  end
end
