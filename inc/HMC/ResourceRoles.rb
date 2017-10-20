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
	
	def decode(string)
	
		string.split("\n").each { |resourceroleString|
				@resourceRoles << ResourceRole.new(resourceroleString)
		}	
	
	end
	
	def has_resource?(role_name, model_type_serial, lpar)
	
		@resourceRoles.each { |role|
			return true  if role.name == role_name and role.has_lpar?(model_type_serial, lpar)
		}
		
		false
	end
	
end	