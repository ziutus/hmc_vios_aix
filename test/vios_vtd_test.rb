$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__) + './lib'

require 'VIOS/Vtd'
require 'test/unit'
require 'pp'

class TestViosVtd < Test::Unit::TestCase

  def test_vtd1

    string = 'VTD                   vtscsi0
Status                Available
LUN                   0x8100000000000000
Backing device        vtd0-1
Physloc'

    vtd = Vtd.new(string)

    assert_equal('vtscsi0', 			      vtd.name)
    assert_equal('Available', 			    vtd.status)
    assert_equal('0x8100000000000000', vtd.lun)
    assert_equal('vtd0-1', 				      vtd.backing_device)
    assert_equal('', 					          vtd.physloc)


  end

  def test_vtd2

    string ='VTD                   vtscsi1
LUN                   0x8200000000000000
Backing device        vtd0-2
Physloc'

    vtd = Vtd.new(string)

    assert_equal('vtscsi1', 			      vtd.name)
    assert_equal('0x8200000000000000', vtd.lun)
    assert_equal('vtd0-2', 				      vtd.backing_device)
    assert_equal('', 					          vtd.physloc)


  end

  def test_vtd3

    string='VTD                   vtscsi2
Status                Available
LUN                   0x8300000000000000
Backing device        hdisk2
Physloc               U787A.001.0397658-P1-T16-L5-L0
Mirrored              false'

    vtd = Vtd.new(string)

    assert_equal('vtscsi2', 			                 vtd.name)
    assert_equal('Available', 			               vtd.status)
    assert_equal('0x8300000000000000', 	           vtd.lun)
    assert_equal('hdisk2', 				                 vtd.backing_device)
    assert_equal('U787A.001.0397658-P1-T16-L5-L0', vtd.physloc)
    assert_equal('false',		                       vtd.mirrored)

  end

  # test data from: http://nixys.fr/blog/?p=618
#   def test_to_s
#     string = 'VTD r7f1_lpar1
# Status Available
# LUN 0x8300000000000000
# Backing device hdisk24
# Physloc U78C0.001.DBJ1531-P2-C5-T1-W50060E80164DFB26-L16000000000000'
#
#     vtd = Vtd.new(string)
#     expected = 'r7f1_lpar1'
#     result = vtd.to_s('svsa', ':')
#     assert_equal(expected, result)
#
#   end

  # test data taken from https://www.ibm.com/support/knowledgecenter/TI0003M/p8hcg/p8hcg_lsmap.htm
  def test_to_s_long_0
    string = '
VTD                   vtscsi0
Status                Available
LUN                   0x8100000000000000
Backing device        vtd0-1
Physloc
'
    string_expected = 'VTD vtscsi0
Status Available
LUN 0x8100000000000000
Backing device vtd0-1
Physloc
'
    vtd = Vtd.new(string)

    assert_equal(string_expected,vtd.to_s_long(1))
  end

  # test data taken from https://www.ibm.com/support/knowledgecenter/TI0003M/p8hcg/p8hcg_lsmap.htm
  def test_to_s_long_2
    string = '
VTD                   vtscsi1
LUN                   0x8200000000000000
Backing device        vtd0-2
Physloc
'
    string_expected = 'VTD vtscsi1
LUN 0x8200000000000000
Backing device vtd0-2
Physloc
'
    vtd = Vtd.new(string)

    assert_equal(string_expected,vtd.to_s_long(1))
  end

  # test data taken from https://www.ibm.com/support/knowledgecenter/TI0003M/p8hcg/p8hcg_lsmap.htm
  def test_to_s_long_3
    string = '
VTD                   vtscsi2
Status                Available
LUN                   0x8300000000000000
Backing device        hdisk2
Physloc               U787A.001.0397658-P1-T16-L5-L0
Mirrored              false'

    string_expected = 'VTD vtscsi2
Status Available
LUN 0x8300000000000000
Backing device hdisk2
Physloc U787A.001.0397658-P1-T16-L5-L0
Mirrored false
'
    vtd = Vtd.new(string)

    assert_equal(string_expected,vtd.to_s_long(1))
  end

  # test data taken from https://www.ibm.com/support/knowledgecenter/TI0003M/p8hcg/p8hcg_lsmap.htm
  def test_to_s_long_fixed_1
    string_expected = 'VTD                   vtscsi0
Status                Available
LUN                   0x8100000000000000
Backing device        vtd0-1
Physloc
'
    string = 'VTD vtscsi0
Status Available
LUN 0x8100000000000000
Backing device vtd0-1
Physloc
'
    vtd = Vtd.new(string)

    assert_equal(string_expected,vtd.to_s_long_fixed)
  end

  # test data taken from https://www.ibm.com/support/knowledgecenter/TI0003M/p8hcg/p8hcg_lsmap.htm
  def test_to_s_long_fixed_2
    string_expected = 'VTD                   vtscsi1
LUN                   0x8200000000000000
Backing device        vtd0-2
Physloc
'
    string = 'VTD vtscsi1
LUN 0x8200000000000000
Backing device vtd0-2
Physloc
'
    vtd = Vtd.new(string)

    assert_equal(string_expected,vtd.to_s_long_fixed)
  end

  # test data taken from https://www.ibm.com/support/knowledgecenter/TI0003M/p8hcg/p8hcg_lsmap.htm
  def test_to_s_long_fixed_3
    string_expected = 'VTD                   vtscsi2
Status                Available
LUN                   0x8300000000000000
Backing device        hdisk2
Physloc               U787A.001.0397658-P1-T16-L5-L0
Mirrored              false
'

    string = 'VTD vtscsi2
Status Available
LUN 0x8300000000000000
Backing device hdisk2
Physloc U787A.001.0397658-P1-T16-L5-L0
Mirrored false
'
    vtd = Vtd.new(string)

    assert_equal(string_expected,vtd.to_s_long_fixed)
  end

  def test_vtd_creating
    vtd1 = Vtd.new
    vtd1.name = 'vtscsi2'
    vtd1.status= 'Available'
    vtd1.lun= '0x8300000000000000'
    vtd1.backing_device = 'hdisk2'
    vtd1.physloc = 'U787A.001.0397658-P1-T16-L5-L0'
    vtd1.mirrored = 'false'

    string_expected = 'VTD                   vtscsi2
Status                Available
LUN                   0x8300000000000000
Backing device        hdisk2
Physloc               U787A.001.0397658-P1-T16-L5-L0
Mirrored              false
'

    assert_equal(string_expected, vtd1.to_s_long_fixed)
  end

end