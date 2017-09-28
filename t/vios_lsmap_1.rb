$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'VIOS/Lsmap'
require "test/unit"
require "pp"

class TestVioslsmap_long < Test::Unit::TestCase

	def test_vtd1
		lsmap = Lsmap.new(DATA.read)

#		lsmap.mapping["vhost2"].vtds.each { |vtd|
#			pp vtd.name
#			pp vtd.backing_device
#		}

		assert_equal(3,	lsmap.mapping["vhost2"].vtds.count)
		assert_equal(4,	lsmap.mapping["vhost4"].vtds.count)

	end
end
	

#DATA.read

# example data source https://www.ibm.com/support/knowledgecenter/en/POWER8/p8hcg/p8hcg_lsmap.htm
# and http://nixys.fr/blog/?p=618
__END__
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
Physloc U78C0.001.DBJ1531-P2-C5-T1-W50060E80164DFB26-L16000000000000
VTD r7u1_lpar1
Status Available
LUN 0x8400000000000000
Backing device hdisk25
Physloc U78C0.001.DBJ1531-P2-C5-T1-W50060E80164DFB26-L19000000000000
