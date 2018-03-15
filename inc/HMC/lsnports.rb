class Lsnports

  attr_reader :data
  attr_reader :data_string_raw

  def initialize(string)

    @data = Hash.new
    @data_string_raw=''


    if string.length > 0
      @data_string_raw = string
      self.parse(string)
    end
  end

  def parse(string)

    string.split("\n").each { |line|
      if line =~ /^\s*name\s+physloc\s+fabric\s+tports\s+aports\s+swwpns\s+awwpns\s*$/
        next
      elsif match = /(fcs\d+)\s+(\w{5}.\d{3}.\w{7}-P\d+-C\d+-T\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s*$/.match(line)

        fcs = Hash.new
        fcs['name'] = match[1]
        fcs['physloc'] = match[2]
        fcs['fabric'] = match[3].to_i
        fcs['tports'] = match[4].to_i
        fcs['aports'] = match[5].to_i
        fcs['swwpns'] = match[6].to_i
        fcs['awwpns'] = match[7].to_i

        @data[fcs['name']] = fcs
      else
        raise Exception, "Wrong string >#{Line}"
      end

    }


  end
end