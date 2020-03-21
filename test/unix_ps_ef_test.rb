$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__)

require 'Unix/Ps_ef'
require 'test/unit'
require 'pp'

class TestUnixPsEf < Test::Unit::TestCase

  def test_ps_ef_1
    #ps_ef = Ps_ef.new(File.read('data/ps_ef.txt'))
    #assert_equal(ps_ef.have_more_children(4), [1527])
  end
end
