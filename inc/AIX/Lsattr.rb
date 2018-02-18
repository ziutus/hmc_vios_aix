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
        tmp = Hash.new
        tmp['value'] = values[i].to_s
        result[headers[i].to_s] = tmp
        i+=1
      end

    result
  end

  def lsattr(string)

    result = Hash.new

    string.split("\n").each do |line|
        if match = %r{(\w+)\s+(\w+)\s+(.*)\s+(True|False)}.match(line)
          tmp = Hash.new
          tmp['attribute']     = match[1].to_s
          tmp['value']         = match[2].to_s
          tmp['description']   = match[3].to_s
          tmp['user_settable'] = match[4].to_s

          result[match[1]] = tmp
        else
          pp line
          raise 'regexp can not decode string'
        end
    end

    result
  end
end