class Lsmpio

  attr_accessor :data_string_raw
  attr_accessor :device
  attr_accessor :data
  attr_accessor :viosname
  attr_accessor :expexted_paths_min

  attr_reader :enabled_all
  attr_reader :name
  attr_reader :_parsed

  def initialize(string = '')
    @data = {}
    @data_string_raw = ''
    @_parsed = false
    @expexted_paths_min = 2

    @enabled_all = false
    @name = nil
    parse(string) unless string.empty?
  end

  def parse(string)
    @data_string_raw = string

    regexp = %r{(hdisk\d+)\s+(\d+)\s+(Enabled|Disabled|Failed|Missing)\s+([\w\,]+)\s+(fscsi\d+)\s+(\w+)\,(\w+)}
    string.each_line do |line|

      line = line.strip
      next if line =~ /name/
      next if line =~ /^\s*$/
      next if line =~ /^[=]+$/

      if match = regexp.match(line)
        @data['paths'] = Hash.new() unless @data.key?('paths')
        @data['paths'][match[2]] = Hash.new()
        @data['paths'][match[2]]['viosname'] = @viosname
        @data['paths'][match[2]]['_line'] = line
        @data['paths'][match[2]]['_validated'] = false
        @data['paths'][match[2]]['name'] = match[1]
        @data['paths'][match[2]]['path'] = match[2]
        @data['paths'][match[2]]['status'] = match[3]
        @data['paths'][match[2]]['path_status'] = match[4]
        @data['paths'][match[2]]['parent'] = match[5]
        @data['paths'][match[2]]['connection'] = match[6] + "," + match[7]
        @data['paths'][match[2]]['connection_port'] = match[6]
        @data['paths'][match[2]]['connection_disk'] = match[7]
      else
        print "line:>" + line + "<\n"
      end
    end

    # data and examples are taken from:
    # https://www.ibm.com/support/knowledgecenter/ssw_aix_72/l_commands/lsmpio.html
    @_parsed = true

  end

  def validate
    @enabled_all = true
    @data['paths'].keys.each do |path_id|
      @enabled_all = false unless @data['paths'][path_id]['status'] == 'Enabled'
    end
  end

end