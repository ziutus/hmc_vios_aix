require 'pp'

class Resource

	attr_reader :type
	attr_reader :lpar
	attr_reader :frame
	attr_reader :type_long


	#cec:root/ibmhscS1_0|9131-52A*6535CCG|IBMHSC_ComputerSystem,
	
	#lpar:root/ibmhscS1_0|ALL_PARTITIONS*9131-52A*6535CCG|IBMHSC_Partition
	#lpar:root/ibmhscS1_0|1*9131-52A*6535CCG|IBMHSC_Partition,
	#lpar:root/ibmhscS1_0|5*9131-52A*6535CCG|IBMHSC_Partition
	def initialize(string='')
		if string.length > 0
			self.decode(string)
		end
	end 
	

	def decode(string)
		
		if match = /lpar:root\/ibmhscS1_0\|(\d+|ALL_PARTITIONS)\*(\d{4}\-\w{3}\*\w{7})\|IBMHSC_Partition/.match(string)
				@type_long  =  "IBMHSC_Partition"
				@type		= "lpar"
				@lpar 		= match[1]
				@frame 		= match[2]
    else
      puts string
			puts regexp
			puts match 
			puts "regexp couldn't decode string #{string}"
			raise 
		end
		
	end

end