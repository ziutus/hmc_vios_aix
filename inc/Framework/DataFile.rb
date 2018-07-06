class DataFile

  #TODO: create table with aliases of commands
  # so if you call command as padmin or using swrole, it shouldn't be difference as result is the same

  attr_accessor :separator

  def initialize(filename, separator = nil)
    @filename = filename
    @separator = separator.empty? ? '| |' : separator

    unless File.readable?(@filename)
      puts "Can't read file #{@filename}" if $DEBUG
      return false
    end
  end

  def find(command, separator = nil)
    data_string = ''
    separator = @separator if separator.empty?

    return false unless File.readable?(@filename)

    File.open(@filename).each do |line|
      tmp = line.split(separator)
      data_string += tmp[1] if tmp[0] =~ /^\s*#{command}\s*(?:2>&1\s*|)$/
    end
    data_string
  end

  def validate
    # each file should have server name, date, version and "---end---" (to validate that all data are taken)
    #
    # TODO: function will return array with errors, if empty, no issues
  end

  def how_old?
    # TODO: function will return seconds from date written in file (it will hep to check if check is not too  old)
  end

  def write(command, value)
    File.open(@filename, 'a') do |file|
      value.split("\n").each do |line|
        file.write(command + '| |' + line + "\n")
      end
    end
  end

  alias Write write

end