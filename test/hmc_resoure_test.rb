$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__)+'./lib'

require 'test/unit'
require 'pp'
require 'HMC/Resource'

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

  # test data taken from: https://www-304.ibm.com/webapp/set2/.../hmc_best_practices.pdf
  def test_cec
    string = 'cec:root/ibmhscS1_0|9406-520*10007CA|IBMHSC_ComputerSystem'
    resource = Resource.new(string)

    assert_equal('IBMHSC_ComputerSystem', resource.type_long)
    assert_equal('cec', resource.type)
    assert_equal('9406-520*10007CA', resource.frame)
  end

  # source: own power5 frame
  def test_frame
    string = 'frame:root/ibmhscS1_0|9131-52A*6535CCG|IBMHSC_Frame'
    resource = Resource.new(string)

    assert_equal('IBMHSC_Frame', resource.type_long)
    assert_equal('frame', resource.type)
    assert_equal('9131-52A*6535CCG', resource.frame)
  end

end