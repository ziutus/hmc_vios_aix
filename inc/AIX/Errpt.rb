require "pp"

require "AIX/ErrptEntry"

class ErrptEntry

	attr_reader   :data_string_raw, :label, :identifier, :timestamp_long
	
#	attr_accessor :break_size
	
	def initialize(string)

		@data_string_raw=''

		if string.length > 0
		  @data_string_raw = string
		  self.parse(string)
		end

	end 

	def parse(string)

		regexp_long = %r{LABEL:\s+([\w\_]+)\s$}
	
		match = regexp_long.match(string)

		if match
			@device         = match[1]	
	
	
	    else
		  puts "can't analyze string, regexp is not working"
		  puts string
		  puts regexp
		  puts match
		  puts "regexp couldn't decode string #{string}"
		  raise
		end

	end
end