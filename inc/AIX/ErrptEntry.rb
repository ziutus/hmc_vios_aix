require "pp"

class ErrptEntry

	attr_reader   :data_string_raw, :label, :identifier, :datetime, :datetime_long, :type, :class, :description, :resource_name
	
#	attr_accessor :break_size
	
	def initialize(string)

		@data_string_raw=''

		if string.length > 0
		  @data_string_raw = string
		  self.parse(string)
		end
	end 

	def parse(string)

		regexp_long = %r{
LABEL:\s+([\w\_]+)\s+
IDENTIFIER:\s+(\w+)\s+
Date\/Time:\s+(\w{3}\s\w{3}\s+\d{1,2}\s\d{1,2}:\d{1,2}:\d{1,2}\s\w{3}\s\d{4})\s+
Sequence\sNumber:\s(\d+)\s+
Machine\sId:\s+(\w+)\s+
Node\sId:\s+(\w+)\s+
Class:\s+(H|I|S)\s+
Type:\s+(TEMP)\s+
Resource\sName:\s+(\w+)\s+          
Resource\sClass:\s+(\w+)\s+
Resource\sType:\s+(\w+)\s+
Location:\s+([\w\/\-]+)\s+
VPD:(.*)
Description(.*)\s+
Probable\sCauses(.*)\s+
User\sCauses(.*)\s+
Failure\sCauses(.*)\s+
Detail\sData(.*)\s+
SENSE\sDATA(.*)}mx

		regexp = %r{(\w{8})\s+(\d{10})\s+(T|P)\s+(S|H|O|U)\s+(\w+)\s+(.*)}

		match      = regexp.match(string)
		match_long = regexp_long.match(string)

		if match 

			@identifier 	= match[1]
			@datetime		= match[2]	
			@type			= match[3]
			@class			= match[4]		
			@resource_name	= match[5]		
			@description	= match[6]		
		
		elsif match_long
		
			@label 			= match_long[1]	
			@identifier 	= match_long[2]
			@datetime_long	= match_long[3]	

	
	    else
		  #puts "can't analyze string, regexp is not working"
		  #puts string
		  #puts regexp
		  #puts match
		  puts "regexp couldn't decode string #{string}"
		  raise
		end

	end
end