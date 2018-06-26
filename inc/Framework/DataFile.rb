class DataFile

  def initialize(fileName)
    @filename  = fileName
  end

  def find(command, separator = '| |')
    data_string = ''

    File.open(@filename).each do |line|
      tmp = line.split(separator)
      data_string += tmp[1] if tmp[0] =~ /^\s*#{command}\s*(?:2>&1\s*|)$/
    end
    data_string
  end

  def Write(command, value)
    File.open(@filename, 'a') do |file|
      value.split("\n").each do |line|
        file.write(command + '| |' + line + "\n")
      end
    end
  end

end