require 'pp'

require 'AIX/ErrptEntry'

class Errpt

  attr_reader :data_string_raw
  attr_reader :errors


  def initialize(string)
    @data_string_raw=''
    @errors = []
    @errors_summary = {}

    parse(string) unless string.empty?
  end

  def parse(string)
    @data_string_raw = string

    if match = %r{LABEL:\s+([\w\_]+)\s$}.match(string)
      # it should be parse in different way
      raise 'this script can not now parse errpt -a output'
    else
      string.split("\n").each { |line|
        next if line =~ /^\s*IDENTIFIER\s+TIMESTAMP\s+T\s+C\s+RESOURCE_NAME\s+DESCRIPTION\s*$/
        @errors.push(ErrptEntry.new(line))
      }
    end
  end

  def summary
    @errors_summary = {}
    @errors.each do |errpt|
      if errpt.description == 'BACK-UP PATH STATUS CHANGE'
        # powerpath issue
      end



    end
  end

end
