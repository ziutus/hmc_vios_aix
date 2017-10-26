class Data_file

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

end