$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/Resource'
require 'HMC/ResourceRole'
require 'pp'

class ResourceRoles

	attr_reader :name
	attr_reader :resources 

	#name=L2support,"resources=cec:root/ibmhscS1_0|9131-52A*6535CCG|IBMHSC_ComputerSystem,lpar:root/ibmhscS1_0|ALL_PARTITIONS*9131-52A*6535CCG|IBMHSC_Partition"
	def initialize string=''

		@roles = Hash.new()
		
		if string.length > 0
			self.decode string 
		end			
	end 
	
	def decode(string)
	
		string.split("\n").each { |resourceroleString|
        role = ResourceRole.new(resourceroleString)
				@roles[role.name] = role
		}	
	
	end
	
	def has_lpar?(role_names, model_type_serial, lpar_id)


    role_names.split(',').each { |role_name|
      if @roles.include?(role_name)
        if @roles[role_name].has_lpar?(model_type_serial, lpar_id)
          return true
        end
      end
    }
 		false
	end

  def lpar_has_roles(model_type_serial, lpar_id)
      result = Array.new
      @roles.each_value { |role|
        result.push(role.name) if role.has_lpar?(model_type_serial, lpar_id)
      }
      result.sort
  end

	def role_exist?(role_name)
    @roles.include?(role_name)
  end

  def role_delete(role_name)
    @roles.delete(role_name)
  end

  def roles_has_all_partitions(model_type_serial)
    result = Array.new
    @roles.each_value { |role|
      result.push(role.name) if role.has_all_partitions?(model_type_serial)
    }
    result.sort

  end

  def role_delete_cmd(role_name)
    "rmaccfg -t resourcerole -n #{role_name}"
  end

  def role_create_cmd(role_name)
    "mkaccfg -t resourcerole -i \"name=#{role_name},resources=\""
  end

  def role_list_cmd
    'lsaccfg  -t resourcerole'
  end

  def lpar_add_to_role_cmd(role_name, type_model_serial, lpar_id)
    "chaccft -t resourcerole -i \"name=#{role_name},resources+=lpar:root/ibmhsc01_0|#{lpar_id}*#{type_model_serial}|IBMHSC_Partition\""
  end

  def lpar_remove_from_role_cmd(role_name , type_model_serial, lpar_id)
    "chaccft -t resourcerole -i \"name=#{role_name},resources-=lpar:root/ibmhsc01_0|#{lpar_id}*#{type_model_serial}|IBMHSC_Partition\""
  end


end	