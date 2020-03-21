class Lsmpio_entry
  attr_reader :string_raw

  attr_reader :name
  attr_reader :path_id
  attr_reader :status
  attr_reader :path_status
  attr_reader :parent
  attr_reader :connection
  attr_reader :connection_port
  attr_reader :connection_disk

  attr_writer :viosname

  def initialize(string = '')
    @string_raw = ''
    @_parsed = false
    parse(string) unless string.empty?
  end

  def parse(string)
    @string_raw = string

    regexp = %r{(hdisk\d+)\s+(\d+)\s+(Enabled|Disabled|Failed|Missing)\s+([\w\,]+)\s+(fscsi\d+)\s+(\w+)\,(\w+)}

    if match = regexp.match(string)
      @name = match[1]
      @path_id = match[2].to_i
      @status = match[3]
      @path_status = match[4]
      @parent = match[5]
      @connection = match[6] + ',' + match[7]
      @connection_port = match[6]
      @connection_disk = match[7]
    else
      print "Wrong line:>" + line + "<\n"
    end
  end

  def to_s(space1_size, space2_size)

    "#{@name}  #{@path_id}   #{@status} #{@path_status} #{@parent} #{@connection}"
  end

end