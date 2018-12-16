require 'pp'

require 'AIX/ErrptEntry'

class Errpt

  attr_reader :data_string_raw
  attr_reader :errors

  attr_reader :errors_summary

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
      string.split("\n").each do |line|
        next if line =~ /^\s*IDENTIFIER\s+TIMESTAMP\s+T\s+C\s+RESOURCE_NAME\s+DESCRIPTION\s*$/
        @errors.push(ErrptEntry.new(line))
      end
    end
  end

  def summary
    @errors_summary = {}

    errors2 = @errors

    puts "----"
    @errors.each_index do |id|
      errpt = @errors[id]
      if errpt.description == 'BACK-UP PATH STATUS CHANGE'
        # powerpath issue
      end

      errors2.each_index {|id2|
        next if id == id2
        errpt_tmp = @errors[id2]
        next if errpt_tmp._in_summary

        if errpt_tmp.compare_short(errpt)
          summary_mark_the_same(errpt_tmp.compare_short_string)
        end
      }

    end
  end

  def summary_mark_the_same(string)

    count = 0
    @errors.each_index do |id|

      if @errors[id].compare_short_string == string
        @errors[id]._in_summary = true
        @errors[id]._show = false
        count += 1
      end
    end

    @errors_summary[string] = count

  end

end
