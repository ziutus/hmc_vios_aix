class DataFile2

  def initialize(filename)
    @filename = filename
  end

  def CheckCommands
    file = File.new(@filename, 'r')
    while (line = file.gets)
      regexp = Regexp.new("###command:(.*)###")
    end
    file.close
  end

  def Write(command, value)
    File.open(@filename, 'a') { |file|
      file.write("###command:#{command}###\n")
      file.write(value)
    }
    # File.close
  end

  def Read(command)
    data_string = ''
    regexp_command = Regexp.new(Regexp.escape(command))
    regexp = Regexp.new('###command')
    insite_command = 0

    file = File.new(@filename, 'r')
    while (line = file.gets)
      match_command = regexp_command.match(line)
      match = regexp.match(line)

      if match && match_command
        insite_command = 1
        next
      elsif match
        insite_command = 0
      end

      if insite_command == 1
        line.delete!("\r")
        data_string += line
      end

    end
    file.close

    data_string
  end

end
