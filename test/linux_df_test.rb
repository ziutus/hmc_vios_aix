$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__)+'./lib'

require 'test/unit'
require 'Linux/df'
require 'Linux/df_entry'
require 'pp'

class LinuxDFEntryTest < Test::Unit::TestCase

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

  # Source of data test: own Linux system
  def test_df_entry_devtmpfs

    df_entry = Df_entry.new('devtmpfs        475M     0  475M   0% /dev')

    assert_equal('devtmpfs', df_entry.filesystem)
    assert_equal('475M', df_entry.size)
    assert_equal('0', df_entry.used)
    assert_equal('475M', df_entry.available)
    assert_equal('0', df_entry.used_percent)
    assert_equal('/dev', df_entry.mounted_on)
  end

  # Source of data test: own Linux system
  def test_df_entry_dev_xvda1

    df_entry = Df_entry.new('/dev/xvda1         8.0G     1.3G  6.8G   16% /')

    assert_equal('/dev/xvda1', df_entry.filesystem)
    assert_equal('8.0G', df_entry.size)
    assert_equal('1.3G', df_entry.used)
    assert_equal('6.8G', df_entry.available)
    assert_equal('16', df_entry.used_percent)
    assert_equal('/', df_entry.mounted_on)
  end



  # Fake test
  def test_df
    string='Filesystem      Size  Used Avail Use% Mounted on
devtmpfs        475M     0  475M   0% /dev
tmpfs           492M     0  492M   0% /dev/shm
tmpfs           492M  436K  492M   1% /run
tmpfs           492M     0  492M   0% /sys/fs/cgroup
/dev/xvda1      8.0G  1.3G  6.8G  16% /
/dev/xvda2      2.0G  1.9G  0  98%   /test
tmpfs            99M     0   99M   0% /run/user/1000
'

    df = Df.new(string)


    df.table.each_key  do | filesystem |
      pp df.table[filesystem] if df.table[filesystem].used_percent.to_i > 90
    end
  end



end