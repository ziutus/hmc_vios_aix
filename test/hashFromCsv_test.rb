$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'test/unit'
require 'HashFromCsv'

include HashFromCsv

class HashFromCsvTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_1
    dataString='col1;col2;col3;
a11;a12;a13;
a21;a22;a23;
a31;a32;a33;'

    data = parseCsvToHash(dataString)

    assert_equal('a11', data['a11']['col1'])
    assert_equal('a12', data['a11']['col2'])
    assert_equal('a13', data['a11']['col3'])

    assert_equal('a11', data['a11']['col1'])
    assert_equal('a12', data['a11']['col2'])
    assert_equal('a13', data['a11']['col3'])

    assert_equal('a21', data['a21']['col1'])
    assert_equal('a22', data['a21']['col2'])
    assert_equal('a23', data['a21']['col3'])

    assert_equal('a31', data['a31']['col1'])
    assert_equal('a32', data['a31']['col2'])
    assert_equal('a33', data['a31']['col3'])

  end
end