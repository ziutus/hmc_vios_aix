$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/Resource'
require "test/unit"
require 'pp'


class TestHMCResource < Test::Unit::TestCase
  
	def test_name
		string = 'lpar:root/ibmhscS1_0|1*9131-52A*6535CCG|IBMHSC_Partition'

		myResource = Resource.new(string)
		
		assert_equal(myResource.type_long, "IBMHSC_Partition")
		assert_equal(myResource.type, "lpar")
		assert_equal(myResource.lpar, "1")
		assert_equal(myResource.frame, "9131-52A*6535CCG")
		
	end

	def test_name2
		string = 'lpar:root/ibmhscS1_0|ALL_PARTITIONS*9131-52A*6535CCG|IBMHSC_Partition'

		myResource = Resource.new(string)

		assert_equal(myResource.type_long, "IBMHSC_Partition")
		assert_equal(myResource.type, "lpar")
		assert_equal(myResource.lpar, "ALL_PARTITIONS")
		assert_equal(myResource.frame, "9131-52A*6535CCG")
		
	end
	
	
end			
		