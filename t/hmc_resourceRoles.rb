$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

test_unit_version=`gem list test-unit`.to_s.scan(/test-unit \((\d\.\d\.\d)/).join
autorunner_file="#{Gem.dir}/gems/test-unit-#{test_unit_version}/lib/test/unit/autorunner.rb"
require autorunner_file if File.exist?(autorunner_file)

require 'HMC/ResourceRole'
require 'HMC/ResourceRoles'
require 'test/unit'


class TestHMCResourceRoles < Test::Unit::TestCase
 
  
	def test_constructor
		string = 'name=L2support,"resources=lpar:root/ibmhscS1_0|ALL_PARTITIONS*9131-52A*6535CCG|IBMHSC_Partition"
name=LparAdmin,"resources=lpar:root/ibmhscS1_0|1*9131-52A*6535CCG|IBMHSC_Partition,lpar:root/ibmhscS1_0|5*9131-52A*6535CCG|IBMHSC_Partition"'

		myResourceRoles = ResourceRoles.new(string)

		assert_equal(myResourceRoles.resourRoleHasResource('LparAdmin', '9131-52A*6535CCG', '1'), 1)
		assert_equal(myResourceRoles.resourRoleHasResource('LparAdmin', '9131-52A*6535CCG', '2'), 0)
			
	end

end			
		