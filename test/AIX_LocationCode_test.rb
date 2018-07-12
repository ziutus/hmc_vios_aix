$LOAD_PATH << File.dirname(__FILE__)+'/../inc'

require 'test/unit'
require 'pp'
require 'AIX/location_code'

class AIXLocationCode_Test < Test::Unit::TestCase

  # example data are taken from: https://www.ibm.com/developerworks/aix/library/au-aix-decoding-location-codes/index.html
  def test_1
    string = 'U789C.001.DQD3F62-P2-D3'

    location_code = LocationCode.new(string)

    assert_equal(string, location_code.location_code_raw)
    assert_equal('U789C', location_code.unit_enclosure_type)
    assert_equal('001', location_code.enclosure_model)
    assert_equal('DQD3F62', location_code.serial_number)
    assert_equal('P2-D3', location_code.location)
  end

  # data source: https://wissamdagher.wordpress.com/category/it/vio/
  def test_2
    #U5803.001.91800ZL-P2-C3-T2
    string = 'U5803.001.91800ZL-P2-C3-T2'

    location_code = LocationCode.new(string)

    assert_equal(string, location_code.location_code_raw)
    assert_equal('U5803', location_code.unit_enclosure_type)
    assert_equal('001', location_code.enclosure_model)
    assert_equal('91800ZL', location_code.serial_number)
    assert_equal('P2-C3-T2', location_code.location)
  end

  # data source: https://www.ibm.com/developerworks/aix/library/au-aix-decoding-location-codes/index.html
  def test_3
    string = 'U789C.001.DQD3F62-P1-C1-T1'
    location_code = LocationCode.new(string)

    assert_equal(string, location_code.location_code_raw)
    assert_equal('U789C', location_code.unit_enclosure_type)
    assert_equal('001', location_code.enclosure_model)
    assert_equal('DQD3F62', location_code.serial_number)
    assert_equal('P1-C1-T1', location_code.location)

    assert_equal('1', location_code.planar)
    assert_equal('1', location_code.card)
    assert_equal('1', location_code.port)

  end

  # data source: https://www.ibm.com/developerworks/aix/library/au-aix-decoding-location-codes/index.html
  def test_4
    string = 'U7879.001.DQD1AE7-P1-T6'

    location_code = LocationCode.new(string)

    assert_equal(string, location_code.location_code_raw)
    assert_equal('U7879', location_code.unit_enclosure_type)
    assert_equal('001', location_code.enclosure_model)
    assert_equal('DQD1AE7', location_code.serial_number)
    assert_equal('P1-T6', location_code.location)

    assert_equal('1', location_code.planar)
    assert_equal('6', location_code.port)
  end

end