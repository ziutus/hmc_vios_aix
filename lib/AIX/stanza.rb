require 'pp'

class Stanza

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

    name = nil

    string.split("\n").each { |line|

      if match = /^(\w+):\s*/.match(line)

        name = match[1]
        @data[name] = Hash.new
      elsif match = /^\s+(\w+)\s*=\s*(.*)\s*$/.match(line)
        argument = match[1]
        value = match[2]

        if argument == 'alloc_count'
          @data[name][argument] = value.to_i
        else
          @data[name][argument] = value
        end

      elsif line =~ /^\s*$/
        next
      else
        raise Exception, "wrong string >#{line}<"
      end
    }

    @data
  end


end