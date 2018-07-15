class DataFile

  #TODO: create table with aliases of commands
  # so if you call command as padmin or using swrole, it shouldn't be difference as result is the same

  attr_accessor :separator
  attr_accessor :verbose

  attr_reader :commands


  def initialize(filename, separator = nil)

    filename.gsub!('/', "\\") if filename =~ /\w:\\/

    @filename = filename
    @separator = separator.nil? ? '| |' : separator

    @commands = []

    @verbose = 0
  end

  def create(version, lparname, date)

    write('ScriptVersion', version)
    write('uname -n', lparname)
    write('date', date)
  end

  def write(command, value)
    File.open(@filename, 'a') do |file|
      value.split("\n").each do |line|
        file.write(command + '| |' + line + "\n")
      end
    end
  end


  def close(command, value)
    write('echo "---end---"', '---end---')
  end


  def list_of_commands
    return false unless File.readable?(@filename)
    separator = @separator
    @commands = []

    File.open(@filename).each do |line|
      tmp = line.split(separator)
      @commands.push(tmp[0]) unless @commands.include?(tmp[0])
    end
  end

  def find(command, separator = nil)

    unless File.readable?(@filename)
      puts "file #{@filename} is not readable!"
      return nil
     end

    list_of_commands if @commands.empty?

    similar_command = find_simiar_command(command)
    command = similar_command unless similar_command.nil?

    data_string = ''
    separator = @separator if separator.nil? or separator.empty?

    File.open(@filename).each do |line|
      tmp = line.split(separator)
      data_string += tmp[1] if tmp[0] =~ /^\s*#{command}\s*(?:2>&1\s*|)$/
    end
    data_string
  end

  def find_simiar_command(command)

    # TODO: move list of commands to separete file, this part should be easier to update
    if command.include?('lsmap') and command.include?('-all')  and command.include?('npiv')
      aliases = [
          'lsmap -npiv -all',
          'lsmap -npiv -all -fmt :',
          'lsmap -all -npiv',
          'lsmap -all -npiv -fmt :',
          '/usr/ios/cli/ioscli lsmap -npiv -all',
          '/usr/ios/cli/ioscli lsmap -npiv -all -fmt :',
          '/usr/ios/cli/ioscli lsmap -all -npiv',
          '/usr/ios/cli/ioscli lsmap -all -npiv -fmt :',
      ]

      aliases.each do |command|
        return command if @commands.include?(command)
      end
    elsif command.include?('lsmap') and command.include?('-all')

      aliases = [
          'lsmap -all',
          'lsmap -all -fmt :',
          '/usr/ios/cli/ioscli lsmap -all',
          '/usr/ios/cli/ioscli lsmap -all -fmt :',
      ]

      aliases.each do |command|
        return command if @commands.include?(command)
      end

    end
    nil
  end

  def validate
    # each file should have server name, date, version and "---end---" (to validate that all data are taken)
    #
    # TODO: function will return array with errors, if empty, no issues
    list_of_commands
    return false unless @commands.include?('date')
    return false unless @commands.include?('uname -n')
    return false unless @commands.include?('ScriptVersion')
    retunr false unless @commands.include?('echo "---end---"')
    true
  end

  def how_old?
    # TODO: function will return seconds from date written in file (it will hep to check if check is not too  old)
  end

  def make_empty
    File.open(@filename, 'w') { |file| file.truncate(0) }
    @commands = []
  end

  alias Write write

end