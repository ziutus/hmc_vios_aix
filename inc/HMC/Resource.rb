require 'pp'

class Resource

	attr_reader :type, :lpar, :frame, :type_long  


	#cec:root/ibmhscS1_0|9131-52A*6535CCG|IBMHSC_ComputerSystem,
	
	#lpar:root/ibmhscS1_0|ALL_PARTITIONS*9131-52A*6535CCG|IBMHSC_Partition
	#lpar:root/ibmhscS1_0|1*9131-52A*6535CCG|IBMHSC_Partition,
	#lpar:root/ibmhscS1_0|5*9131-52A*6535CCG|IBMHSC_Partition
	def initialize string=""
		if string.length > 0
			decode(string)
		end
	end 
	

	def decode string 
		
		regexp = /lpar:root\/ibmhscS1_0\|(\d+|ALL_PARTITIONS)\*(\d{4}\-\w{3}\*\w{7})\|IBMHSC_Partition/
		
		match = regexp.match(string)
		
		
		if match 
				@type_long  =  "IBMHSC_Partition"
				@type		= "lpar"
				@lpar 		= match[1]
				@frame 		= match[2]
		end
		
		unless match 
			puts string 
			puts regexp
			puts match 
			puts "regexp couldn't decode string #{string}"
			raise 
		end
		
#		pp match
		
#		@name=match[1]
#		puts match[2]
		
		
		
	end

end