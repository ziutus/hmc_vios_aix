$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'test/unit'
require_relative '../inc/ibm_case'

class IBM_rcms_pmr_Test < Test::Unit::TestCase


  # Fake test
  def test1
    rcms = IbmCase.new('72401DDDDD')

    assert_equal('01DDDDD.724', rcms.id_nice)
    assert_equal('rcms', rcms.type)
  end

  def test2
    rcms = IbmCase.new('01DDDDD.724')

    assert_equal('01DDDDD.724', rcms.id_nice)
    assert_equal('rcms', rcms.type)
  end


  def test3
    rcms = IbmCase.new('12345,567,123')

    assert_equal('12345.567.123', rcms.id_nice)
    assert_equal('pmr', rcms.type)
  end

end