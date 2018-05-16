require 'pp'

class LspartitionDlpar


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

    string.gsub!("\nActive", "Active")

    ##pp string

    string.split("\n").each { |line|

        #pp line

    if match = /\<\#(\d+)\>\s+Partition:\<\d+\*\w{4}\-\w{3}\*\w{6,7}\,\s+([\w\.]+)\,\s+(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\>Active:\<(0|1)\>\,\sOS:\<(AIX|[\s\,]+)\>,\sDCaps:\<0x2f\>\,\sCmdCaps:\<0x0b,\s0x0b\>,\sPinnedMem:\<(\d+)\>/.match(line)

        row = Hash.new
        row['entry'] = match[1].to_i
        row['lpar_id'] = match[2].to_i
        row['system'] = match[3]
        row['lpar_address'] = match[4]
        row['ip'] = match[5]
        row['OS'] = match[6]
        row['DCaps'] = match[7]
        row['CmdCaps'] = match[8]
        row['PinnedMem'] = match[9]
        #
        @data[row['entry']] = row
      else
        raise Exception, "Wrong string >#{line}"
      end

    }


  end

end