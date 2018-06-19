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
end
