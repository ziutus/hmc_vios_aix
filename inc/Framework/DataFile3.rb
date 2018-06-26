class DataFile3

  def initialize(filename, comment = nil)
    @filename = filename

    unless File.exist?(filename)
      File.open(@filename, 'a') do |file|
        file.write("### file format:3.0 ###\n")
      end

      unless comment.nil?
        File.open(@filename, 'a') do |file|
          file.write("### comment:#{comment} ###\n")
        end
      end
    end
  end

  def write(command, value)
    File.open(@filename, 'a') do |file|
      file.write("### command:#{command} ### time:#{Time.now.strftime("%Y-m-d_%H:%M:%S")} ### timestamp: #{Time.now.to_i} ###\n")
      file.write(value)
    end
  end
  alias Write write

  def list_commands
    result = {}

    file = File.new(@filename, 'r')
    while (line = file.gets)
      if match = /### command: (.*) ### time:(.*) ### timestamp: (\d+) ###/.match(line)
        result[match[1]] = [] if result[match[1]].nil?
        result[match[1]].push(match[3])
      end
    end

    result
  end
  alias ListCommands list_commands

  def read(command)
    result = {}
    insite_command = 0
    timestamp = nil

    file = File.new(@filename, 'r')
    while (line = file.gets)

      if match = /### command: (.*) ### time:(.*) ### timestamp: (\d+) ###/.match(line)
        match[1] == command ? insite_command = 1 : insite_command = 0
        timestamp = match[3]
        next
      end

      if insite_command == 1
        if result[timestamp].nil?
          result[timestamp] = line.delete("\r")
        else
          result[timestamp] += line.delete("\r")
        end
      end
    end
    file.close

    result
  end
  alias Read read

end
