$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/ResourceRole'
require 'HMC/ResourceRoles'
require "test/unit"


class TestHMCResourceRole < Test::Unit::TestCase
 
  
	def test_name
		string = 'name=LparAdmin,"resources=lpar:root/ibmhscS1_0|1*9131-52A*6535CCG|IBMHSC_Partition,lpar:root/ibmhscS1_0|5*9131-52A*6535CCG|IBMHSC_Partition"'

		myResourceRole = ResourceRole.new()
		myResourceRole.decode(string)
		
		myResourceRole.hasResource("9131-52A*6535CCG", 1)
		
		assert_equal(myResourceRole.name, "LparAdmin")
		assert_equal(myResourceRole.hasResource("9131-52A*6535CCG", 1), 1)
		assert_equal(myResourceRole.hasResource("9131-52A*6535CCG", 4), 0)
		
	end

	def test_all_partitions
		string = 'name=LparAdmin,"resources=lpar:root/ibmhscS1_0|1*9131-52A*6535CCE|IBMHSC_Partition,lpar:root/ibmhscS1_0|ALL_PARTITIONS*9131-52A*6535CCG|IBMHSC_Partition"'

		myResourceRole = ResourceRole.new()
		myResourceRole.decode(string)
		
		myResourceRole.hasResource("9131-52A*6535CCG", "ALL_PARTITIONS")
		
		assert_equal(myResourceRole.name, "LparAdmin")
		assert_equal(myResourceRole.hasResource("9131-52A*6535CCG", 1), 1)
		
	end

	def test_constructor_with_string
		string = 'name=LparAdmin,"resources=lpar:root/ibmhscS1_0|1*9131-52A*6535CCG|IBMHSC_Partition,lpar:root/ibmhscS1_0|5*9131-52A*6535CCG|IBMHSC_Partition"'

		myResourceRole = ResourceRole.new(string)
		
		myResourceRole.hasResource("9131-52A*6535CCG", 1)
		
		assert_equal(myResourceRole.name, "LparAdmin")
		assert_equal(myResourceRole.hasResource("9131-52A*6535CCG", 1), 1)
		assert_equal(myResourceRole.hasResource("9131-52A*6535CCG", 4), 0)
		
	end

end			
		