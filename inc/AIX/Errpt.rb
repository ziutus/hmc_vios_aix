require "pp"

require "AIX/ErrptEntry"

class Errpt

	attr_reader :data_string_raw
  attr_reader :errors


	def initialize(string)

		@data_string_raw=''
    @errors = Array.new

		if string.length > 0
		  self.parse(string)
		end

	end 

	def parse(string)

    @data_string_raw = string

		if match = %r{LABEL:\s+([\w\_]+)\s$}.match(string)
			# it should be parse in different way
      raise 'this script can not now parse errpt -a output'
    else
      string.split("\n").each { |line|
        @errors.push(ErrptEntry.new(line))
      }
		end
  end

  def summary
    @errors.each { |errpt|
      if errpt.description == 'BACK-UP PATH STATUS CHANGE'

      end

    }
  end

end
