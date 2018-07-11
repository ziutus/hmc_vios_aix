$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'VIOS/Lsmap'
require 'test/unit'
require 'pp'

class TestVioslsmap_long < Test::Unit::TestCase

# 2018/06/19 - test file has been rebuild for covering every test case (more test needed and vhost names were duplicated)
#
# example data source https://www.ibm.com/support/knowledgecenter/en/POWER8/p8hcg/p8hcg_lsmap.htm
# and http://nixys.fr/blog/?p=618
#
# "VTD NO VIRTUAL TARGET DEVICE FOUND" taken from (vhost12 created as copy of vhost2 for post)
# https://www.ibm.com/developerworks/community/forums/html/topic?id=77777777-0000-0000-0000-000014422737


  def test_vtd1
    lsmap = Lsmap.new(File.read(File.join('test', 'vios_lsmap_data.txt')))

    assert_equal(8, lsmap.mapping.count)

    assert_equal(0,	lsmap.mapping['vhost0'].vtds.count)
    assert_equal(3,	lsmap.mapping['vhost1'].vtds.count)
    assert_equal(0,	lsmap.mapping['vhost2'].vtds.count)
    assert_equal(4,	lsmap.mapping['vhost3'].vtds.count)
    assert_equal(0,	lsmap.mapping['vhost4'].vtds.count)
    assert_equal(3,	lsmap.mapping['vhost5'].vtds.count)
    assert_equal(0,	lsmap.mapping['vhost6'].vtds.count)
    assert_equal(4,	lsmap.mapping['vhost7'].vtds.count)

    vhosts = lsmap.mapping_for_lpar(4)

    assert_equal(4, vhosts.count, 'lpar 4 has 4 vhosts')

    backing_devices = lsmap.backing_devices_for_lpar(4)

    assert_equal(14,	backing_devices.count)
    assert_equal(true, backing_devices.include?('hdisk2'))
    assert_equal(true, backing_devices.include?('hdisk27'))
    assert_equal(false, backing_devices.include?('hdisk127'))
    assert_equal(true, backing_devices.include?('vtd0-1'))

    lpars = lsmap.lpars
    assert_equal(3,	lpars.count)
    assert_equal(true, lpars.include?(0))
    assert_equal(false, lpars.include?(1))
    assert_equal(true, lpars.include?(28))

  end

  # test data source: http://nixys.fr/blog/?p=618
  def test_vhost_to_s
    string = 'SVSA Physloc Client Partition ID
--------------- -------------------------------------------- ------------------
vhost4 U9117.MMB.999BCP-V2-C8 0x00000008
VTD d7f1_lpar1
Status Available
LUN 0x8100000000000000
Backing device hdisk25
Physloc U78C0.001.DBJ1531-P2-C5-T1-W50060F80164D0B26-L17000000000000
VTD d7f1n1_lpar1
Status Available
LUN 0x8200000000000000
Backing device hdisk26
Physloc U78C0.001.DBJ1531-P2-C5-T1-W50060F80164D0B26-L18000000000000
VTD r7f1_lpar1
Status Available
LUN 0x8300000000000000
Backing device hdisk24
Physloc U78C0.001.DBJ1531-P2-C5-T1-W50060E80164DFB26-L16000000000000'

    expected = "vhost4:d7f1_lpar1:d7f1n1_lpar1:r7f1_lpar1\n"
    lsmap = Lsmap.new(string)

    result = lsmap.to_s('vtd:svsa', ':')

    assert_equal(expected, result)

  end

  # test data source: http://nixys.fr/blog/?p=618
  def test_vhost_to_s2
    string = 'SVSA Physloc Client Partition ID
--------------- -------------------------------------------- ------------------
vhost4 U9117.MMB.999BCP-V2-C8 0x00000008
VTD d7f1_lpar1
Status Available
LUN 0x8100000000000000
Backing device hdisk25
Physloc U78C0.001.DBJ1531-P2-C5-T1-W50060F80164D0B26-L17000000000000
VTD d7f1n1_lpar1
Status Available
LUN 0x8200000000000000
Backing device hdisk26
Physloc U78C0.001.DBJ1531-P2-C5-T1-W50060F80164D0B26-L18000000000000
VTD r7f1_lpar1
Status Available
LUN 0x8300000000000000
Backing device hdisk24
Physloc U78C0.001.DBJ1531-P2-C5-T1-W50060E80164DFB26-L16000000000000'

    expected = "vhost4 d7f1_lpar1 d7f1n1_lpar1 r7f1_lpar1\n"
    lsmap = Lsmap.new(string)

    result = lsmap.to_s('vtd svsa', ' ')

    assert_equal(expected, result)

  end

  def test_lsmap__fixed_no_devices
    string = 'SVSA Physloc Client Partition ID
--------------- -------------------------------------------- ------------------
vhost0 U9131.52A.10E47DG-V3-C31 0x00000000

NO VIRTUAL TARGET DEVICE FOUND
'

    vhost = Vhost.new
    vhost.name = 'vhost0'
    vhost.physloc = 'U9131.52A.10E47DG-V3-C31'
    vhost.client_partition_id = '0x00000000'

    lsmap = Lsmap.new
    lsmap.mapping['vhost0'] = vhost

    #puts lsmap.to_s_long_fixed
    #assert_equal(string, lsmap.to_s_long_fixed)

  end

end
