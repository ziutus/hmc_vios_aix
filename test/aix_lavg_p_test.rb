$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'AIX/lsvg_p'
require 'test/unit'
require 'pp'


class TestAixLsvgEntry < Test::Unit::TestCase

  # based on from: http://www-01.ibm.com/support/docview.wss?uid=isg3T1020096
  def test_decode_0
    string='
datavg:
PV_NAME           PV STATE          TOTAL PPs   FREE PPs    FREE DISTRIBUTION
hdisk5            active            646         486         130..00..98..129..129
hdisk6            missing           646         6           00..00..00..00..06
hdisk7            active            646         486         130..00..98..129..129'

    entry = Lsvg_p.new(string)
    assert_equal('datavg',    entry.volume_group)

    assert_equal(1,    entry.missing.count)
    assert_equal(2,    entry.active.count)

    assert_equal(true,    entry.missing.include?('hdisk6'))
    assert_equal(true,    entry.active.include?('hdisk5'))
    assert_equal(true,    entry.active.include?('hdisk7'))

    assert_equal('hdisk5',    entry.disks['hdisk5']['pv_name'])
    assert_equal('active',    entry.disks['hdisk5']['pv_state'])
    assert_equal(646,    entry.disks['hdisk5']['total_pps'])
    assert_equal(486,    entry.disks['hdisk5']['free_pps'])
    assert_equal('130..00..98..129..129',    entry.disks['hdisk5']['free_distribution'])

    assert_equal('hdisk6',    entry.disks['hdisk6']['pv_name'])
    assert_equal('missing',    entry.disks['hdisk6']['pv_state'])
    assert_equal(646,    entry.disks['hdisk6']['total_pps'])
    assert_equal(6,    entry.disks['hdisk6']['free_pps'])
    assert_equal('00..00..00..00..06',    entry.disks['hdisk6']['free_distribution'])

    assert_equal('hdisk7',    entry.disks['hdisk7']['pv_name'])
    assert_equal('active',    entry.disks['hdisk7']['pv_state'])
    assert_equal(646,    entry.disks['hdisk7']['total_pps'])
    assert_equal(486,    entry.disks['hdisk7']['free_pps'])
    assert_equal('130..00..98..129..129',    entry.disks['hdisk7']['free_distribution'])

  end
end