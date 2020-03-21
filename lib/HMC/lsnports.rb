class Lsnports

  attr_reader :data
  attr_reader :data_string_raw

  def initialize(string)
    @data = {}
    @data_string_raw = ''

    parse(string) unless string.empty?
  end

  def parse(string)
    @data_string_raw = string

    string.split("\n").each do |line|
      if line =~ %r{^\s*name\s+physloc\s+fabric\s+tports\s+aports\s+swwpns\s+awwpns\s*$}
        next
      elsif match = %r{(fcs\d+)\s+(\w{5}.\d{3}.\w{7}-P\d+-C\d+-T\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s*$}.match(line)

        fcs = {}
        fcs['name'] = match[1]
        fcs['physloc'] = match[2]
        fcs['fabric'] = match[3].to_i
        fcs['tports'] = match[4].to_i
        fcs['aports'] = match[5].to_i
        fcs['swwpns'] = match[6].to_i
        fcs['awwpns'] = match[7].to_i

        @data[fcs['name']] = fcs
      else
        raise Exception, "Wrong string >#{line}"
      end

    end

  end
end