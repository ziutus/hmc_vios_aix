$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/Resource'
require 'HMC/ResourceRole'
require 'pp'

class ResourceRoles

	attr_reader :name
	attr_reader :resources 

	#name=L2support,"resources=cec:root/ibmhscS1_0|9131-52A*6535CCG|IBMHSC_ComputerSystem,lpar:root/ibmhscS1_0|ALL_PARTITIONS*9131-52A*6535CCG|IBMHSC_Partition"
	def initialize string=""

		@resourceRoles = Array.new()
		
		if string.length > 0
			self.decode string 
		end			
	end 
	
	def decode string 
	

		lines = string.split("\n")
		
		lines.each { |resourceroleString|
				#pp resourceroleString
				@resourceRoles << ResourceRole.new(resourceroleString)	
		}	
	
	end
	
	def resourRoleHasResource role,frame,lpar 
	
		@resourceRoles.each { |resoureRole|
			if resoureRole.name == role
				if resoureRole.hasResource(frame,lpar) == 1
					return 1
				end
			end
		}
		
		return 0
	end
	
end	