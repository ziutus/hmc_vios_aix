$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'test/unit'
require 'Unix/uptime'

class UnixWTest < Test::Unit::TestCase

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
  def test_5_days
    string=' 17:13:12 up 5 days, 21:00,  0 users,  load average: 0,52, 0,58, 0,59'

    uptime = Uptime.new
    uptime.parse_simple(string)

    assert_equal('17:13:12', uptime.time)
    assert_equal('5 days, 21:00', uptime.up)
    assert_equal(0, uptime.users)
    assert_equal('0,52, 0,58, 0,59', uptime.load)
    assert_equal('0,52', uptime.load_1)
    assert_equal('0,58', uptime.load_5)
    assert_equal('0,59', uptime.load_15)

  end

  def test_just_booted
    string = '18:51:38 up 0 min,  1 user,  load average: 0,53, 0,19, 0,07'
    uptime = Uptime.new
    uptime.parse_simple(string)

    assert_equal('18:51:38', uptime.time)
    assert_equal('0 min', uptime.up)
    assert_equal(1, uptime.users)
    assert_equal('0,53, 0,19, 0,07', uptime.load)
    assert_equal('0,53', uptime.load_1)
    assert_equal('0,19', uptime.load_5)
    assert_equal('0,07', uptime.load_15)
  end

  def test_2_hours
    string = '20:59:12 up  2:08,  2 users,  load average: 0,05, 0,02, 0,00'

    uptime = Uptime.new
    uptime.parse_simple(string)

    assert_equal('20:59:12', uptime.time)
    assert_equal('2:08', uptime.up)
    assert_equal(2, uptime.users)
    assert_equal('0,05, 0,02, 0,00', uptime.load)
    assert_equal('0,05', uptime.load_1)
    assert_equal('0,02', uptime.load_5)
    assert_equal('0,00', uptime.load_15)

  end

end