class DataFile

  def initialize(fileName)
    @fileName  = fileName
  end

  def find(command, separator ='| |')
    data_string = '';

    File.open(@fileName).each { |line|
      tmp = line.split(separator)
      data_string += tmp[1] if tmp[0] =~ /^\s*#{command}\s*(?:2>&1\s*|)$/
    }
    data_string
  end

  def Write(command, value)
    File.open(@fileName, 'a') { |file|

      value.split("\n").each { |line|
          file.write(command + '| |' + line + "\n" )
      }
    }
  end


end