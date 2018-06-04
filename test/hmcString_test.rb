$LOAD_PATH << File.dirname(__FILE__)+'/../inc'

require 'test/unit'
require 'pp'
require 'HMC/HmcString'

include HmcString

# "--require <gem home>/test-unit-3.2.3/lib/test/unit/autorunner"
#  --require "C:/Ruby24/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test-unit.rb"

class TestString < Test::Unit::TestCase

  def test_String

    string = 'name=L2support,"resources=lpar:root/ibmhscS1_0|1*9131-52A*6535CCG|IBMHSC_Partition,lpar:root/ibmhscS1_0|5*9131-52A*6535CCG|IBMHSC_Partition",nameLong=L2supportRole'

    hash = HmcString.parse(string)

    assert_equal('L2support', hash['name'], 'name - L2support')
    assert_equal('L2supportRole', hash['nameLong'], 'nameLong - L2supportRole')

  end

  def test_string_hmc_value_with_comma

      #let's test case, when virtual adapter has 3 adapters and one of them has 3 vlans
      string ='virtual_scsi_adapters=none,"virtual_eth_adapters=3/1/1/10/0/1,""2/1/1/3,4,5/0/1"",3/1/1/10/0/1",hca_adapters=none'

      hash = HmcString.parse(string)

      assert_equal('none', hash['virtual_scsi_adapters'], 'virtual_scsi_adapters - none')
      assert_equal('none', hash['hca_adapters'],          'hca_adapters - none')
      assert_equal('3/1/1/10/0/1,""2/1/1/3,4,5/0/1"",3/1/1/10/0/1', hash['virtual_eth_adapters'], 'virtual_eth_adapters - none')

  end

  
 def test_string_hmc_value_with_comma_2

      #let's test case, when virtual adapter has 3 adapters and one of them has 3 vlans
      string ='virtual_scsi_adapters=none,"virtual_eth_adapters=""2/1/1/3,4,5/0/1""",hca_adapters=none'
	
      hash = HmcString.parse(string)

      assert_equal('none', hash['virtual_scsi_adapters'], 'virtual_scsi_adapters - none')
      assert_equal('""2/1/1/3,4,5/0/1""', hash['virtual_eth_adapters'], 'virtual_eth_adapters - none')
      assert_equal('none', hash['hca_adapters'], 'hca_adapters - none')
	
  end
  
  
  def test_parse_value
      string = '3/1/1/10/0/1,""2/1/1/3,4,5/0/1"",3/1/1/10/0/1'
      array = HmcString.parse_value(string)

      assert_equal('3/1/1/10/0/1',    array[0])
      assert_equal('2/1/1/3,4,5/0/1', array[1])
      assert_equal('3/1/1/10/0/1',    array[2])
	
  end

  def test_parse_value_2
      string = '""2/1/1/3,4,5/0/1""'
      array = HmcString.parse_value(string)

      assert_equal('2/1/1/3,4,5/0/1', array[0])
  end

  def test_make_string

    assert_equal(nil, make_string('name', nil))
    assert_equal('virtual_eth_adapters=2/1/1//0/1', make_string('virtual_eth_adapters', '2/1/1//0/1'))
    assert_equal('"virtual_serial_adapters=0/server/1/any//any/1,1/server/1/any//any/1"', make_string('virtual_serial_adapters', '0/server/1/any//any/1,1/server/1/any//any/1'))
    assert_equal('"virtual_fc_adapters=""504/client/2/vio_server1/8/c050760431670010,c050760431670011/1"",""604/client/3/vio_server2/5/c050760431670012,c050760431670013/1"""', make_string('virtual_fc_adapters', '""504/client/2/vio_server1/8/c050760431670010,c050760431670011/1"",""604/client/3/vio_server2/5/c050760431670012,c050760431670013/1""') )

  end

  def test_crazy

    hash = HmcString.parse('a=b,c=d=e,f=g')

    assert_equal('b',   hash['a'], 'crazy test - a')
    assert_equal('d=e', hash['c'], 'crazy test - c')
    assert_equal('g',   hash['f'], 'crazy test - f')

  end

end