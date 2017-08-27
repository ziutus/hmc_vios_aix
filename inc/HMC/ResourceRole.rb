$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/Resource'
require 'pp'

class ResourceRole

	attr_reader :name
	attr_reader :resources 

	#name=L2support,"resources=cec:root/ibmhscS1_0|9131-52A*6535CCG|IBMHSC_ComputerSystem,lpar:root/ibmhscS1_0|ALL_PARTITIONS*9131-52A*6535CCG|IBMHSC_Partition"
	def initialize string=""

		@resources = Array.new()
		
		if string.length > 0
			self.decode string 
		end	
	end 
	

	def decode string 
		
		regexp = /name=([\w]+),"resources=(.*)"/
		match = regexp.match(string)
		
		unless match 
			puts string 
			puts regexp
			puts match 
			puts "regexp couldn't decode string #{string}"
			raise 
		end
		
		@name=match[1]

		resources = match[2].split(",")
		
		resources.each { |resource|
				@resources << Resource.new(resource)	
		}
		
	end
	
	def hasResource frame,lparID  
		
		@resources.each { |resource|
				if resource.type == "lpar" 
					if resource.frame == frame and resource.lpar == "ALL_PARTITIONS"
						return 1
					end

					if resource.frame == frame and resource.lpar == lparID.to_s
						return 1
					end
				end
		}		
		
		0
	end

end