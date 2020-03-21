$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__)+'./lib'

require 'test/unit'
require 'VIOS/lsmap_net_entry'
require 'VIOS/lsmap_net'

require 'test/unit'

class ViosLsmapNetTest < Test::Unit::TestCase


  # data for test taken from: http://aix-skills.blogspot.com/2013/06/resetting-networkin-vios-virtual-io.html
  def test_no_shared_adapter_found
    string ='SVEA Physloc
------ --------------------------------------------
ent7 U7998.61X.100113A-V1-C6-T1

SEA NO SHARED ETHERNET ADAPTER FOUND'

    sea = Lsmap_net_entry.new(string)
    assert_equal('ent7', sea.svea)
    assert_equal('U7998.61X.100113A-V1-C6-T1', sea.physloc)
  end

  # test data taken from http://www.unixwerk.eu/aix/ios-howto.html#C1
  def test_test1
    string = 'SVEA	Physloc
 ------ --------------------------------------------
 ent12	U9117.570.65E12FB-V2-C20-T1

 SEA                   ent13
 Backing device        ent3
 Physloc               U7311.D20.651372C-P1-C01-T2'

    sea = Lsmap_net_entry.new(string)

    assert_equal('ent12', sea.svea)
    assert_equal('U9117.570.65E12FB-V2-C20-T1', sea.physloc)
    assert_equal('ent13', sea.sea)
    assert_equal('ent3', sea.backing)
    assert_equal('U7311.D20.651372C-P1-C01-T2', sea.bdphysloc)
  end

  # data source for test: https://it.toolbox.com/question/sea-not-seeing-network-021611
  def test_test2
    string = 'SVEA Physloc
------ --------
ent2 U9110.510.10004AA-V1-C2-T1

SEA ent3
Backing device ent0
Status Available
Physloc U787E.001.0DQ0079-P1-T1 '

    sea = Lsmap_net_entry.new(string)

    assert_equal('ent2', sea.svea)
    assert_equal('U9110.510.10004AA-V1-C2-T1', sea.physloc)
    assert_equal('ent3', sea.sea)
    assert_equal('ent0', sea.backing)
    assert_equal('Available', sea.status)
    assert_equal('U787E.001.0DQ0079-P1-T1', sea.bdphysloc)
  end

  def test_3
    string ='SVEA Physloc
------
ent10 U9179.MHB.100000-V1-C2-T1

SEA ent11
Backing device ent0
Status Available
Physloc U78C0.001.DBJ4508-P2-C8-T2 '

    sea = Lsmap_net_entry.new(string)

    assert_equal('ent10', sea.svea)
    assert_equal('U9179.MHB.100000-V1-C2-T1', sea.physloc)
    assert_equal('ent11', sea.sea)
    assert_equal('ent0', sea.backing)
    assert_equal('Available', sea.status)
    assert_equal('U78C0.001.DBJ4508-P2-C8-T2', sea.bdphysloc)

  end

  # Data test source: https://www.ibm.com/support/knowledgecenter/9109-RMD/p7hcg/lsmap.htm (point 3)
  def test_fmt
    string = 'ent3:U8204.E8A.06A85B2-V13-C11-T1:ent10:ent1:Available:U7311.D20.06168AC-P1-C06-T1'
  end

  # data source: http://aix-skills.blogspot.com/2013/06/resetting-networkin-vios-virtual-io.html
  def test_long
    string = 'SVEA Physloc
------ --------------------------------------------
ent4 U7998.61X.100113A-V1-C3-T1

SEA ent8
Backing device ent0
Status Available
Physloc U78A5.001.WIH01E0-P1-T6

SVEA Physloc
------ --------------------------------------------
ent5 U7998.61X.100113A-V1-C4-T1

SEA ent9
Backing device ent1
Status Available
Physloc U78A5.001.WIH01E0-P1-T7

SVEA Physloc
------ --------------------------------------------
ent6 U7998.61X.100113A-V1-C5-T1

SEA NO SHARED ETHERNET ADAPTER FOUND

SVEA Physloc
------ --------------------------------------------
ent7 U7998.61X.100113A-V1-C6-T1

SEA NO SHARED ETHERNET ADAPTER FOUND'

    lsmap_net = Lsmap_net.new(string)

    assert_equal(4, lsmap_net.data.count)

  end
end