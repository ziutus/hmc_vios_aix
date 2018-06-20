$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'test/unit'
require 'Unix/w'

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
  def test_fail
    string=' 17:13:12 up 5 days, 21:00,  0 users,  load average: 0,52, 0,58, 0,59
UŻYTK.  TTY      Z                ZAL.OD   BEZCZ. JCPU   PCPU CO'

    w = W.new
    w.parse_simple(string)

    assert_equal('17:13:12', w.time)
    assert_equal('5 days, 21:00', w.up)
    assert_equal(0, w.users)
    assert_equal('0,52, 0,58, 0,59', w.load)
    assert_equal('0,52', w.load_1)
    assert_equal('0,58', w.load_5)
    assert_equal('0,59', w.load_15)

  end

  def test_just_booted
    string = '18:51:38 up 0 min,  1 user,  load average: 0,53, 0,19, 0,07
USER     TTY        LOGIN@   IDLE   JCPU   PCPU WHAT
root     pts/0     18:51    1.00s  0.10s  0.03s w
'
    w = W.new
    w.parse_simple(string)

    assert_equal('18:51:38', w.time)
    assert_equal('0 min', w.up)
    assert_equal(1, w.users)
    assert_equal('0,53, 0,19, 0,07', w.load)
    assert_equal('0,53', w.load_1)
    assert_equal('0,19', w.load_5)
    assert_equal('0,07', w.load_15)
  end

  def test_2_hours
    string = '20:59:12 up  2:08,  2 users,  load average: 0,05, 0,02, 0,00
USER     TTY        LOGIN@   IDLE   JCPU   PCPU WHAT
root     pts/0     18:51    2:07m  0.07s  0.07s -bash
root     pts/1     20:59    0.00s  0.08s  0.03s w
'

    w = W.new
    w.parse_simple(string)

    assert_equal('20:59:12', w.time)
    assert_equal('2:08', w.up)
    assert_equal(2, w.users)
    assert_equal('0,05, 0,02, 0,00', w.load)
    assert_equal('0,05', w.load_1)
    assert_equal('0,02', w.load_5)
    assert_equal('0,00', w.load_15)

  end

end