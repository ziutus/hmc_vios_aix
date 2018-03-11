$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

require 'test/unit'
require 'HMC/ResourceRole'
require 'HMC/ResourceRoles'

class TestHMCResourceRole < Test::Unit::TestCase
 
  
	def test_name
		string = 'name=LparAdmin,"resources=lpar:root/ibmhscS1_0|1*9131-52A*6535CCG|IBMHSC_Partition,lpar:root/ibmhscS1_0|5*9131-52A*6535CCG|IBMHSC_Partition"'

		myResourceRole = ResourceRole.new
		myResourceRole.decode(string)
		
		myResourceRole.has_lpar?('9131-52A*6535CCG', 1)
		
		assert_equal(myResourceRole.name, 'LparAdmin')
		assert_equal(myResourceRole.has_lpar?('9131-52A*6535CCG', 1), true)
		assert_equal(myResourceRole.has_lpar?('9131-52A*6535CCG', 4), false)
		
	end

	def test_all_partitions
		string = 'name=LparAdmin,"resources=lpar:root/ibmhscS1_0|1*9131-52A*6535CCE|IBMHSC_Partition,lpar:root/ibmhscS1_0|ALL_PARTITIONS*9131-52A*6535CCG|IBMHSC_Partition"'

		myResourceRole = ResourceRole.new
		myResourceRole.decode(string)
		
		myResourceRole.has_lpar?('9131-52A*6535CCG', 'ALL_PARTITIONS')

    assert_equal(true,  myResourceRole.has_all_lpars?('9131-52A*6535CCG'))
    assert_equal(false, myResourceRole.has_all_lpars?('9131-52A*6535CCE'))


		assert_equal('LparAdmin', myResourceRole.name)
		assert_equal(true,        myResourceRole.has_lpar?('9131-52A*6535CCG', 1))
		
	end

	def test_constructor_with_string
		string = 'name=LparAdmin,"resources=lpar:root/ibmhscS1_0|1*9131-52A*6535CCG|IBMHSC_Partition,lpar:root/ibmhscS1_0|5*9131-52A*6535CCG|IBMHSC_Partition"'

		myResourceRole = ResourceRole.new(string)
		
		assert_equal(myResourceRole.name, 'LparAdmin')
		assert_equal(myResourceRole.has_lpar?('9131-52A*6535CCG', 1), true)
		assert_equal(myResourceRole.has_lpar?('9131-52A*6535CCG', 4), false)
		
  end

  def test_empty_resources
    string = 'name=LparAdmin,resources='

    myResourceRole = ResourceRole.new(string)
    assert_equal(myResourceRole.name, 'LparAdmin')

  end

  def test_constructor_with_string_one_resource
    string = 'name=LparAdmin,resources=lpar:root/ibmhscS1_0|1*9131-52A*6535CCG|IBMHSC_Partition'

    myResourceRole = ResourceRole.new(string)

    assert_equal(myResourceRole.name, 'LparAdmin')
    assert_equal(myResourceRole.has_lpar?('9131-52A*6535CCG', 1), true)
    assert_equal(myResourceRole.has_lpar?('9131-52A*6535CCG', 4), false)

  end

	def test_constructor_with_string_missing_IBMHSC_Partition
		string = 'name=LparAdmin,resources=lpar:root/ibmhscS1_0|1*9131-52A*6535CCG'

		myResourceRole = ResourceRole.new(string)

		assert_equal(myResourceRole.name, 'LparAdmin')
		assert_equal(myResourceRole.has_lpar?('9131-52A*6535CCG', 1), true)
		assert_equal(myResourceRole.has_lpar?('9131-52A*6535CCG', 4), false)

	end

end			
		