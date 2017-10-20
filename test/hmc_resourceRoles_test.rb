$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

require 'HMC/ResourceRole'
require 'HMC/ResourceRoles'
require 'test/unit'

class TestHMCResourceRoles < Test::Unit::TestCase

  
	def test_constructor
		string = 'name=L2support,"resources=lpar:root/ibmhscS1_0|ALL_PARTITIONS*9131-52A*6535CCG|IBMHSC_Partition"
name=LparAdmin,"resources=lpar:root/ibmhscS1_0|1*9131-52A*6535CCG|IBMHSC_Partition,lpar:root/ibmhscS1_0|5*9131-52A*6535CCG|IBMHSC_Partition"'

		roles = ResourceRoles.new(string)

		assert_equal(roles.has_resource?('LparAdmin', '9131-52A*6535CCG', '1'), true)
		assert_equal(roles.has_resource?('LparAdmin', '9131-52A*6535CCG', '2'), false)
			
	end

end			
		