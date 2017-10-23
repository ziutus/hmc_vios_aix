$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/Resource'
require 'pp'

class ResourceRole

	attr_reader :name
	attr_reader :resources 

	#name=L2support,"resources=cec:root/ibmhscS1_0|9131-52A*6535CCG|IBMHSC_ComputerSystem,lpar:root/ibmhscS1_0|ALL_PARTITIONS*9131-52A*6535CCG|IBMHSC_Partition"
	def initialize(string='')

		@resources = Array.new()
		
		if string.length > 0
			self.decode string 
		end	
	end 
	

	def decode(string)

    raise 'new line character in string' if string.include?("\n")

		if match = /^name=([\w]+),"resources=(.*?)"$/.match(string)

			@name=match[1]
			match[2].split(',').each { |resource|
				@resources.push(Resource.new(resource))
			}
		else
			puts string 
			puts regexp
			puts "regexp couldn't decode string"
			raise 
		end
		

	end
	
	def has_lpar?(type_model_serial, lpar_id)
		
		@resources.each { |resource|
				if resource.type == 'lpar'
					if resource.frame == type_model_serial and resource.lpar == 'ALL_PARTITIONS'
						return true
					end

					if resource.frame == type_model_serial and resource.lpar == lpar_id.to_s
						return true
					end
				end
		}		
		
		false
	end

  def has_all_lpars?(type_model_serial)
    @resources.each { |resource|
      return true if resource.type == 'lpar' if resource.frame == type_model_serial and resource.lpar == 'ALL_PARTITIONS'
    }
    false
  end
end