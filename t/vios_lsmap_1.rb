$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'
$LOAD_PATH << File.dirname(__FILE__)

require 'VIOS/Lsmap'
require 'test/unit'
require 'pp'

class TestVioslsmap_long < Test::Unit::TestCase

	def test_vtd1
		lsmap = Lsmap.new(DATA.read)

#    pp lsmap.mapping.keys

#		lsmap.mapping["vhost2"].vtds.each { |vtd|
#			pp vtd.name
#			pp vtd.backing_device
#		}

		assert_equal(0,	lsmap.mapping['vhost0'].vtds.count)
		assert_equal(3,	lsmap.mapping['vhost2'].vtds.count)
		assert_equal(4,	lsmap.mapping['vhost4'].vtds.count)
		assert_equal(0,	lsmap.mapping['vhost3'].vtds.count)


    vhosts =  lsmap.mapping_for_lpar(4)

    assert_equal(2, vhosts.count, 'lpar 4 has 2 vhosts')

    backing_devices = lsmap.backing_devices_for_lpar(4)

    assert_equal(7,	backing_devices.count)
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
	

#DATA.read

# example data source https://www.ibm.com/support/knowledgecenter/en/POWER8/p8hcg/p8hcg_lsmap.htm
# and http://nixys.fr/blog/?p=618
#
# "VTD NO VIRTUAL TARGET DEVICE FOUND" taken from (vhost12 created as copy of vhost2 for post)
# https://www.ibm.com/developerworks/community/forums/html/topic?id=77777777-0000-0000-0000-000014422737
__END__
SVSA Physloc Client Partition ID
--------------- -------------------------------------------- ------------------
vhost0 U9131.52A.10E47DG-V3-C31 0x00000000

NO VIRTUAL TARGET DEVICE FOUND

 SVSA                 Physloc				Client Partition ID
-------------        --------------------------------- -----------------------------
vhost2       	      U9111.520.10004BA-V1-C2           0x00000004

VTD                   vtscsi0
Status                Available
LUN                   0x8100000000000000
Backing device        vtd0-1
Physloc

VTD                   vtscsi1
LUN                   0x8200000000000000
Backing device        vtd0-2
Physloc

VTD                   vtscsi2
Status                Available
LUN                   0x8300000000000000
Backing device        hdisk2
Physloc               U787A.001.0397658-P1-T16-L5-L0
Mirrored              false

SVSA Physloc Client Partition ID
--------------- -------------------------------------------- ------------------
vhost3 U9131.52A.10E47DG-V3-C34 0x0000001c

VTD NO VIRTUAL TARGET DEVICE FOUND

SVSA Physloc Client Partition ID
--------------- -------------------------------------------- ------------------
vhost4 U9117.MMB.999BCP-V2-C8 0x00000004
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
Physloc U78C0.001.DBJ1531-P2-C5-T1-W50060E80164DFB26-L16000000000000
VTD r7u1_lpar1
Status Available
LUN 0x8400000000000000
Backing device hdisk27
Physloc U78C0.001.DBJ1531-P2-C5-T1-W50060E80164DFB26-L19000000000000


SVSA Physloc Client Partition ID
--------------- -------------------------------------------- ------------------
vhost0 U9131.52A.10E47DG-V3-C31 0x00000000

NO VIRTUAL TARGET DEVICE FOUND

 SVSA                 Physloc				Client Partition ID
-------------        --------------------------------- -----------------------------
vhost2       	      U9111.520.10004BA-V1-C2           0x00000004

VTD                   vtscsi0
Status                Available
LUN                   0x8100000000000000
Backing device        vtd0-1
Physloc

VTD                   vtscsi1
LUN                   0x8200000000000000
Backing device        vtd0-2
Physloc

VTD                   vtscsi2
Status                Available
LUN                   0x8300000000000000
Backing device        hdisk2
Physloc               U787A.001.0397658-P1-T16-L5-L0
Mirrored              false

SVSA Physloc Client Partition ID
--------------- -------------------------------------------- ------------------
vhost3 U9131.52A.10E47DG-V3-C34 0x0000001c

VTD NO VIRTUAL TARGET DEVICE FOUND

SVSA Physloc Client Partition ID
--------------- -------------------------------------------- ------------------
vhost4 U9117.MMB.999BCP-V2-C8 0x00000004
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
Physloc U78C0.001.DBJ1531-P2-C5-T1-W50060E80164DFB26-L16000000000000
VTD r7u1_lpar1
Status Available
LUN 0x8400000000000000
Backing device hdisk27
Physloc U78C0.001.DBJ1531-P2-C5-T1-W50060E80164DFB26-L19000000000000
