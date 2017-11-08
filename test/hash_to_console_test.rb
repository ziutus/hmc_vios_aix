$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'test/unit'
require 'hash_to_consol'


class HashToConsoleTest < Test::Unit::TestCase

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

     console = HashToConsol.new

    console.add_row(%w(name value1 value2))
     console.add_row(%w(name v1 v2))

   result =  console.to_s
    result = result.split("\n")

    assert_equal('name;    v1;    v2;', result[1])


  end
end