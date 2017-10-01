$LOAD_PATH << File.dirname(__FILE__)+"/../inc"

require "test/unit"
require 'pp'
require 'HMC/HmcString'

include HmcString

# "--require <gem home>/test-unit-3.2.3/lib/test/unit/autorunner"
#  --require "C:/Ruby24/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test-unit.rb"

class TestString < Test::Unit::TestCase

  def test_String

    string = 'name=L2support,"resources=lpar:root/ibmhscS1_0|1*9131-52A*6535CCG|IBMHSC_Partition,lpar:root/ibmhscS1_0|5*9131-52A*6535CCG|IBMHSC_Partition",nameLong=L2supportRole';

    myHash = HmcString.parse(string)

    assert_equal("L2support",     myHash["name"],     "name - L2support")
    assert_equal("L2supportRole", myHash["nameLong"], "nameLong - L2supportRole")

  end

  def test_string_hmc_value_with_comma

	#let's test case, when virtual adapter has 3 adapters and one of them has 3 vlans 
	string ='virtual_scsi_adapters=none,"virtual_eth_adapters=3/1/1/10/0/1,""2/1/1/3,4,5/0/1"",3/1/1/10/0/1",hca_adapters=none'
	
    myHash = HmcString.parse(string)

    assert_equal('none',     myHash["virtual_scsi_adapters"],     "virtual_scsi_adapters - none")
	assert_equal('3/1/1/10/0/1,""2/1/1/3,4,5/0/1"",3/1/1/10/0/1', myHash["virtual_eth_adapters"], "virtual_eth_adapters - none" )
    assert_equal('none',     myHash["hca_adapters"],     		  "hca_adapters - none")
	
  end

  
 def test_string_hmc_value_with_comma_2

	#let's test case, when virtual adapter has 3 adapters and one of them has 3 vlans 
	string ='virtual_scsi_adapters=none,"virtual_eth_adapters=""2/1/1/3,4,5/0/1""",hca_adapters=none'
	
    myHash = HmcString.parse(string)

    assert_equal('none',     myHash["virtual_scsi_adapters"],     "virtual_scsi_adapters - none")
	assert_equal('""2/1/1/3,4,5/0/1""', myHash["virtual_eth_adapters"], "virtual_eth_adapters - none" )
    assert_equal('none',     myHash["hca_adapters"],     		  "hca_adapters - none")
	
  end
  
  
  def test_parse_value
	string = '3/1/1/10/0/1,""2/1/1/3,4,5/0/1"",3/1/1/10/0/1'
	myArray = HmcString.parse_value(string)
	
	assert_equal('3/1/1/10/0/1', myArray[0])
	assert_equal('2/1/1/3,4,5/0/1', myArray[1])
	assert_equal('3/1/1/10/0/1', myArray[2])
	
  end

  def test_parse_value_2
	string = '""2/1/1/3,4,5/0/1""'
	myArray = HmcString.parse_value(string)
	
	assert_equal('2/1/1/3,4,5/0/1', myArray[0])
	
  end

  
end