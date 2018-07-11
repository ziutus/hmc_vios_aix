$LOAD_PATH << File.dirname(__FILE__)+"/../inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'VIOS/Vhost'
require 'VIOS/Lsmap'
require 'test/unit'
require 'pp'

class TestViosVtd < Test::Unit::TestCase

  def test_vhost1

    string='vhost2       	      U9111.520.10004BA-V1-C2           0x0000000b'
    vhost = Vhost.new(string)

    assert_equal('vhost2', 			             vhost.name)
    assert_equal('U9111.520.10004BA-V1-C2', vhost.physloc)
    assert_equal('0x0000000b', 			         vhost.client_partition_id)
    assert_equal(11, 			    		           vhost.client_partition_id_nice)
  end


  def test_to_s_long_1
    string ='SVSA Physloc Client Partition ID
--------------- -------------------------------------------- ------------------
vhost0 U9131.52A.10E47DG-V3-C31 0x00000000

NO VIRTUAL TARGET DEVICE FOUND
'

    vhost = Vhost.new(string)

    assert_equal('vhost0', vhost.name)
    assert_equal('U9131.52A.10E47DG-V3-C31', vhost.physloc)
    assert_equal('0x00000000', vhost.client_partition_id)
    assert_equal(0, vhost.client_partition_id_nice)
    assert_equal(0, vhost.vtds.count)

    string_expected = 'SVSA Physloc Client Partition ID
------------- --------------------------------- ------------------
vhost0 U9131.52A.10E47DG-V3-C31 0x00000000

NO VIRTUAL TARGET DEVICE FOUND'

    vhost2 = Vhost.new(vhost.to_s_long)

    assert_equal('vhost0', vhost2.name)
    assert_equal('U9131.52A.10E47DG-V3-C31', vhost2.physloc)
    assert_equal('0x00000000', vhost2.client_partition_id)
    assert_equal(0, vhost2.client_partition_id_nice)
    assert_equal(0, vhost2.vtds.count)


  end

  def test_vhost_to_s_long_2

    string = 'SVSA                 Physloc				Client Partition ID
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
Mirrored              false'

    string_expected = 'SVSA Physloc Client Partition ID
------------- --------------------------------- ------------------
vhost2 U9111.520.10004BA-V1-C2 0x00000004

VTD vtscsi0
Status Available
LUN 0x8100000000000000
Backing device vtd0-1
Physloc

VTD vtscsi1
LUN 0x8200000000000000
Backing device vtd0-2
Physloc

VTD vtscsi2
Status Available
LUN 0x8300000000000000
Backing device hdisk2
Physloc U787A.001.0397658-P1-T16-L5-L0
Mirrored false
'
    lsmap = Lsmap.new(string)
    vhost = lsmap.mapping['vhost2']

    assert_equal(string_expected, vhost.to_s_long)
  end

  def test_vhost_to_s_long_fixed

    string = 'SVSA Physloc Client Partition ID
------------- --------------------------------- ------------------
vhost2 U9111.520.10004BA-V1-C2 0x00000004

VTD vtscsi0
Status Available
LUN 0x8100000000000000
Backing device vtd0-1
Physloc

VTD vtscsi1
LUN 0x8200000000000000
Backing device vtd0-2
Physloc

VTD vtscsi2
Status Available
LUN 0x8300000000000000
Backing device hdisk2
Physloc U787A.001.0397658-P1-T16-L5-L0
Mirrored false
'

    string_expected = 'SVSA                 Physloc                           Client Partition ID
-------------        --------------------------------- ------------------
vhost2               U9111.520.10004BA-V1-C2           0x00000004

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
'

    lsmap = Lsmap.new(string)
    vhost = lsmap.mapping['vhost2']

    assert_equal(string_expected, vhost.to_s_long_fixed)
  end

  # test data taken from: https://www.ibm.com/support/knowledgecenter/TI0003M/p8hcg/p8hcg_lsmap.htm
  def test_creating_vhost
    vhost = Vhost.new()
    vhost.name = 'vhost2'
    vhost.physloc = 'U9111.520.10004BA-V1-C2'
    vhost.client_partition_id = '0x00000004'


    vtd1 = Vtd.new
    vtd1.name = 'vtscsi2'
    vtd1.status= 'Available'
    vtd1.lun= '0x8300000000000000'
    vtd1.backing_device = 'hdisk2'
    vtd1.physloc = 'U787A.001.0397658-P1-T16-L5-L0'
    vtd1.mirrored = 'false'

    vhost.vtds.push(vtd1)

    string_expected = 'SVSA                 Physloc                           Client Partition ID
-------------        --------------------------------- ------------------
vhost2               U9111.520.10004BA-V1-C2           0x00000004

VTD                   vtscsi2
Status                Available
LUN                   0x8300000000000000
Backing device        hdisk2
Physloc               U787A.001.0397658-P1-T16-L5-L0
Mirrored              false
'
    assert_equal(string_expected, vhost.to_s_long_fixed)
  end

end