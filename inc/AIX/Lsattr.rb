module Lsattr


  def lsattr_O(string)

    result = Hash.new

    lines = string.split("\n")

    headers = lines[0].split(':')
    values  = lines[1].split(':')

    headers[0].gsub!("#", '')

#    raise "Wrong number of lines" if lines.count != 2

      i=0
      while i < headers.count
        result[headers[i].to_s] = values[i].to_s
        i+=1
      end

    result
  end

end