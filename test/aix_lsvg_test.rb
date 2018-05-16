$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'AIX/Lsvg'
require 'test/unit'
require 'pp'


class TestAixLsvgEntry < Test::Unit::TestCase

  # based on from: http://www.kristijan.org/2010/05/calculate-total-usage-in-aix-volume-group/
  def test_decode_data_1
    string='
VOLUME GROUP:       data                     VG IDENTIFIER:  000771a50000d6000000011bd8f66761
VG STATE:           active                   PP SIZE:        128 megabyte(s)
VG PERMISSION:      read/write               TOTAL PPs:      13410 (1716480 megabytes)
MAX LVs:            256                      FREE PPs:       7729 (989312 megabytes)
LVs:                1                       USED PPs:       2 (727168 megabytes)
OPEN LVs:           3                       QUORUM:         4
TOTAL PVs:          5                        VG DESCRIPTORS: 6
STALE PVs:          7                        STALE PPs:      8
ACTIVE PVs:         9                        AUTO ON:        yes
MAX PPs per VG:     10
MAX PPs per PV:     11                     MAX PVs:        12
LTG size (Dynamic): 256 kilobyte(s)          AUTO SYNC:      no
HOT SPARE:          no                       BB POLICY:      relocatable'

    entry = Lsvg.new(string)
    assert_equal('data',    entry.volume_group)
    assert_equal('000771a50000d6000000011bd8f66761',    entry.vg_identifier)
    assert_equal('active',    entry.vg_state)
    assert_equal('128 megabyte(s)',    entry.pp_size)
    assert_equal('read/write',    entry.vg_permission)
    assert_equal(13410,    entry.total_pps)
    assert_equal(256,    entry.max_lvs)
    assert_equal(7729,    entry.free_pps)
    assert_equal(1,    entry.lvs)
    assert_equal(2,    entry.used_pps)
    assert_equal(3,    entry.open_lvs)
    assert_equal(4,    entry.quorum)
    assert_equal(5,    entry.total_pvs)
    assert_equal(6,    entry.vg_descriptors)
    assert_equal(7,    entry.stale_pvs)
    assert_equal(8,    entry.stale_pps)
    assert_equal(9,    entry.active_pvs)
    assert_equal('yes',    entry.auto_on)
    assert_equal(10,    entry.max_pps_per_vg)
    assert_equal(11,    entry.max_pps_per_pv)
    assert_equal(12,    entry.max_pvs)
    assert_equal('256 kilobyte(s)',    entry.ltg_size_dynamic)
    assert_equal('no',    entry.auto_sync)
    assert_equal('no',    entry.hot_spare)
    assert_equal('relocatable',    entry.bb_policy)

  end

  # example data taken from: http://www.kristijan.org/2010/05/calculate-total-usage-in-aix-volume-group/
  def test_decode_1
    string='
VOLUME GROUP:       data                     VG IDENTIFIER:  000771a50000d6000000011bd8f66761
VG STATE:           active                   PP SIZE:        128 megabyte(s)
VG PERMISSION:      read/write               TOTAL PPs:      13410 (1716480 megabytes)
MAX LVs:            256                      FREE PPs:       7729 (989312 megabytes)
LVs:                12                       USED PPs:       5681 (727168 megabytes)
OPEN LVs:           12                       QUORUM:         4
TOTAL PVs:          6                        VG DESCRIPTORS: 6
STALE PVs:          0                        STALE PPs:      0
ACTIVE PVs:         6                        AUTO ON:        yes
MAX PPs per VG:     30480
MAX PPs per PV:     3048                     MAX PVs:        10
LTG size (Dynamic): 256 kilobyte(s)          AUTO SYNC:      no
HOT SPARE:          no                       BB POLICY:      relocatable'

    entry = Lsvg.new(string)
    assert_equal('data',    entry.volume_group)
    assert_equal('000771a50000d6000000011bd8f66761',    entry.vg_identifier)
    assert_equal('active',    entry.vg_state)
    assert_equal('128 megabyte(s)',    entry.pp_size)
    assert_equal('read/write',    entry.vg_permission)
    assert_equal(13410,    entry.total_pps)
    assert_equal(256,    entry.max_lvs)
    assert_equal(7729,    entry.free_pps)
    assert_equal(12,    entry.lvs)
    assert_equal(5681,    entry.used_pps)
    assert_equal(12,    entry.open_lvs)
    assert_equal(4,    entry.quorum)
    assert_equal(6,    entry.total_pvs)
    assert_equal(6,    entry.vg_descriptors)
    assert_equal(0,    entry.stale_pvs)
    assert_equal(0,    entry.stale_pps)
    assert_equal(6,    entry.active_pvs)
    assert_equal('yes',    entry.auto_on)
    assert_equal(30480,    entry.max_pps_per_vg)
    assert_equal(3048,    entry.max_pps_per_pv)
    assert_equal(10,    entry.max_pvs)

    assert_equal('256 kilobyte(s)',    entry.ltg_size_dynamic)
    assert_equal('no',    entry.hot_spare)
    assert_equal('no',    entry.auto_sync)
    assert_equal('relocatable',    entry.bb_policy)

  end

  # example data taken from: https://faruqueahmed.wordpress.com/2015/02/11/increase-paging-space-in-ibm-aix-7-1/
  def test_decode_critical_vg
    string ='VOLUME GROUP: rootvg VG IDENTIFIER: 00f9766800004c00000001495fceed84
VG STATE: active PP SIZE: 128 megabyte(s)
VG PERMISSION: read/write TOTAL PPs: 759 (97152 megabytes)
MAX LVs: 256 FREE PPs: 347 (44416 megabytes)
LVs: 13 USED PPs: 412 (52736 megabytes)
OPEN LVs: 12 QUORUM: 2 (Enabled)
TOTAL PVs: 1 VG DESCRIPTORS: 2
STALE PVs: 0 STALE PPs: 0
ACTIVE PVs: 1 AUTO ON: yes
MAX PPs per VG: 32512
MAX PPs per PV: 1016 MAX PVs: 32
LTG size (Dynamic): 256 kilobyte(s) AUTO SYNC: no
HOT SPARE: no BB POLICY: relocatable
PV RESTRICTION: none INFINITE RETRY: no
DISK BLOCK SIZE: 512 CRITICAL VG: no'

    entry = Lsvg.new(string)
    assert_equal('rootvg',    entry.volume_group)
    assert_equal('00f9766800004c00000001495fceed84',    entry.vg_identifier)
    assert_equal('active',    entry.vg_state)
    assert_equal('128 megabyte(s)',    entry.pp_size)
    assert_equal('read/write',    entry.vg_permission)
    assert_equal(759,    entry.total_pps)
    assert_equal(256,    entry.max_lvs)
    assert_equal(347,    entry.free_pps)
    assert_equal(13,    entry.lvs)
    assert_equal(412,    entry.used_pps)
    assert_equal(12,    entry.open_lvs)
    assert_equal(2,    entry.quorum)
    assert_equal(1,    entry.total_pvs)
    assert_equal(2,    entry.vg_descriptors)
    assert_equal(0,    entry.stale_pvs)
    assert_equal(0,    entry.stale_pps)
    assert_equal(1,    entry.active_pvs)
    assert_equal('yes',    entry.auto_on)
    assert_equal(32512,    entry.max_pps_per_vg)
    assert_equal(1016,    entry.max_pps_per_pv)
    assert_equal(32,    entry.max_pvs)

    assert_equal('256 kilobyte(s)',    entry.ltg_size_dynamic)
    assert_equal('no',    entry.auto_sync)
    assert_equal('no',    entry.hot_spare)
    assert_equal('relocatable',    entry.bb_policy)

    assert_equal('none',    entry.pv_restriction)
    assert_equal('no',    entry.infinite_retry)

    assert_equal(512,    entry.disk_block_size)
    assert_equal('no',    entry.critical_vg)

  end


end