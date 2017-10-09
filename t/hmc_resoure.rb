$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

test_unit_version=`gem list test-unit`.to_s.scan(/test-unit \((\d\.\d\.\d)/).join
autorunner_file="#{Gem.dir}/gems/test-unit-#{test_unit_version}/lib/test/unit/autorunner.rb"
require autorunner_file if File.exist?(autorunner_file)


require 'HMC/Resource'
require 'test/unit'
require 'pp'


class TestHMCResource < Test::Unit::TestCase
  
	def test_name
		string = 'lpar:root/ibmhscS1_0|1*9131-52A*6535CCG|IBMHSC_Partition'

		resource = Resource.new(string)
		
		assert_equal('IBMHSC_Partition', resource.type_long)
		assert_equal('lpar',             resource.type )
		assert_equal('1',                resource.lpar )
		assert_equal('9131-52A*6535CCG', resource.frame)
		
	end

	def test_name2
		string = 'lpar:root/ibmhscS1_0|ALL_PARTITIONS*9131-52A*6535CCG|IBMHSC_Partition'

		resource = Resource.new(string)

		assert_equal('IBMHSC_Partition', resource.type_long, )
		assert_equal('lpar',             resource.type, )
		assert_equal('ALL_PARTITIONS',   resource.lpar)
		assert_equal('9131-52A*6535CCG', resource.frame)
		
	end
	
	
end			
		