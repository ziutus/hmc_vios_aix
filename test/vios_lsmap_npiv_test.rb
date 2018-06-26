$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'test/unit'
require 'VIOS/lsmap_npiv_entry'
require 'VIOS/lsmap_npiv'

class ViosLsmapNpivTest < Test::Unit::TestCase

  # test data taken from: https://wissamdagher.wordpress.com/2013/05/09/vio-npiv-mapping-to-fc-unmap/
  def entry_logged

string = 'Name          Physloc                            ClntID ClntName       ClntOS
————- ———————————- —— ————– ——-
vfchost4      U9119.FHA.44337FA-V2-C165             160 WASUAT         AIX

Status:LOGGED_IN
FC name:fcs1                    FC loc code:U5803.001.91800ZL-P2-C3-T2
Ports logged in:1
Flags:a<LOGGED_IN,STRIP_MERGE>
    VFC client name:fcs0            VFC client DRC:U9119.FHA.44337FA-V160-C5'

    entry = Lsmap_npiv_entry.new(string)

    assert_equal('vfchost4', entry.name)
    assert_equal('U9119.FHA.44337FA-V2-C165', entry.physloc)
    assert_equal(160, entry.clntid)
    assert_equal('WASUAT', entry.clntname)
    assert_equal('AIX', entry.clntos)
    assert_equal('LOGGED_IN', entry.status)
    assert_equal('fcs1', entry.fc_name)
    assert_equal('U5803.001.91800ZL-P2-C3-T2', entry.fc_loc_code)
    assert_equal(1, entry.ports_logged_in)
    assert_equal('a<LOGGED_IN,STRIP_MERGE>', entry.flags)
    assert_equal('fcs0', entry.vfc_client_name)
    assert_equal('U9119.FHA.44337FA-V160-C5', entry.vfc_client_drc)
  end

  #test data taken from: https://wissamdagher.wordpress.com/2013/05/09/vio-npiv-mapping-to-fc-unmap/
  def entry_not_mapped

    string = 'Name          Physloc                            ClntID ClntName       ClntOS
————- ———————————- —— ————– ——-
vfchost4      U9119.FHA.44337FA-V2-C165             160

Status:NOT_LOGGED_IN
FC name:                        FC loc code:
Ports logged in:0
Flags:1<NOT_MAPPED,NOT_CONNECTED>
VFC client name:                VFC client DRC:'

    entry = Lsmap_npiv_entry.new(string)

    assert_equal('vfchost4', entry.name)
    assert_equal('U9119.FHA.44337FA-V2-C165', entry.physloc)
    assert_equal(160, entry.clntid)
    assert_equal('', entry.clntname)
    assert_equal('', entry.clntos)
    assert_equal('NOT_LOGGED_IN', entry.status)
    assert_equal('', entry.fc_name)
    assert_equal('', entry.fc_loc_code)
    assert_equal(0, entry.ports_logged_in)
    assert_equal('1<NOT_MAPPED,NOT_CONNECTED>', entry.flags)
    assert_equal('', entry.vfc_client_name)
    assert_equal('', entry.vfc_client_drc)
  end


  # test taken from: https://www.ibm.com/developerworks/aix/library/au-NPIV/
  def test_entry_logged_2

    string = 'Name          Physloc                            ClntID ClntName       ClntOS
------------- ---------------------------------- ------ -------------- -------
vfchost0      U8233.E8B.XXXXXXX-V1-C66                4 LPAR4          AIX

Status:LOGGED_IN
FC name:fcs0                    FC loc code:U78A0.001.XXXXXXX-P1-C3-T1
Ports logged in:5
Flags:a<LOGGED_IN,STRIP_MERGE>
VFC client name:fcs0            VFC client DRC:U8233.E8B.XXXXXXX-V6-C30-T1
'

    entry = Lsmap_npiv_entry.new(string)

    assert_equal('vfchost0', entry.name)
    assert_equal('U8233.E8B.XXXXXXX-V1-C66', entry.physloc)
    assert_equal(4, entry.clntid)
    assert_equal('LPAR4', entry.clntname)
    assert_equal('AIX', entry.clntos)
    assert_equal('LOGGED_IN', entry.status)
    assert_equal('fcs0', entry.fc_name)
    assert_equal('U78A0.001.XXXXXXX-P1-C3-T1', entry.fc_loc_code)
    assert_equal(5, entry.ports_logged_in)
    assert_equal('a<LOGGED_IN,STRIP_MERGE>', entry.flags)
    assert_equal('fcs0', entry.vfc_client_name)
    assert_equal('U8233.E8B.XXXXXXX-V6-C30-T1', entry.vfc_client_drc)
  end


# test taken from: https://www.ibm.com/developerworks/aix/library/au-NPIV/
  def test_entry_2_vfchosts

    string = 'Name          Physloc                            ClntID ClntName       ClntOS
------------- ---------------------------------- ------ -------------- -------
vfchost0      U8233.E8B.XXXXXXX-V1-C66                4 LPAR4          AIX

Status:LOGGED_IN
FC name:fcs0                    FC loc code:U78A0.001.XXXXXXX-P1-C3-T1
Ports logged in:5
Flags:a<LOGGED_IN,STRIP_MERGE>
VFC client name:fcs0            VFC client DRC:U8233.E8B.XXXXXXX-V6-C30-T1

Name          Physloc                            ClntID ClntName       ClntOS
------------- ---------------------------------- ------ -------------- -------
vfchost1      U8233.E8B.XXXXXXX-V1-C67                4 LPAR4          AIX

Status:LOGGED_IN
FC name:fcs1                    FC loc code:U78A0.001.XXXXXXX-P1-C3-T2
Ports logged in:5
Flags:a<LOGGED_IN,STRIP_MERGE>
VFC client name:fcs1            VFC client DRC:U8233.E8B.XXXXXXX-V6-C31-T1'

    lsmap = Lsmap_npiv.new(string)

    assert_equal('vfchost0', lsmap.data['vfchost0'].name)
    assert_equal('U8233.E8B.XXXXXXX-V1-C66', lsmap.data['vfchost0'].physloc)
    assert_equal(4, lsmap.data['vfchost0'].clntid)
    assert_equal('LPAR4', lsmap.data['vfchost0'].clntname)
    assert_equal('AIX', lsmap.data['vfchost0'].clntos)
    assert_equal('LOGGED_IN', lsmap.data['vfchost0'].status)
    assert_equal('fcs0', lsmap.data['vfchost0'].fc_name)
    assert_equal('U78A0.001.XXXXXXX-P1-C3-T1', lsmap.data['vfchost0'].fc_loc_code)
    assert_equal(5, lsmap.data['vfchost0'].ports_logged_in)
    assert_equal('a<LOGGED_IN,STRIP_MERGE>', lsmap.data['vfchost0'].flags)
    assert_equal('fcs0', lsmap.data['vfchost0'].vfc_client_name)
    assert_equal('U8233.E8B.XXXXXXX-V6-C30-T1', lsmap.data['vfchost0'].vfc_client_drc)
  end


  # test data source: https://www.ibm.com/developerworks/community/blogs/cgaix/entry/power_systems_sms_san_zoning_support1?lang=en
  def test_lpar_down

    string = 'Name          Physloc                            ClntID ClntName       ClntOS
------------- ---------------------------------- ------ -------------- -------
vfchost41     U9119.FHA.99D99C1-V2-C199              99

Status:NOT_LOGGED_IN
FC name:fcs4                    FC loc code:U5803.001.9912345-P2-C5-T1
Ports logged in:0
Flags:4<NOT_LOGGED>
VFC client name:                VFC client DRC:'

    lsmap = Lsmap_npiv.new(string)

    assert_equal('vfchost41',                 lsmap.data['vfchost41'].name)
    assert_equal('U9119.FHA.99D99C1-V2-C199', lsmap.data['vfchost41'].physloc)
    assert_equal(99,                          lsmap.data['vfchost41'].clntid)
    assert_equal('',                          lsmap.data['vfchost41'].clntname)
    assert_equal('',                          lsmap.data['vfchost41'].clntos)
    assert_equal('NOT_LOGGED_IN',             lsmap.data['vfchost41'].status)
    assert_equal('fcs4',                      lsmap.data['vfchost41'].fc_name)
    assert_equal('U5803.001.9912345-P2-C5-T1',lsmap.data['vfchost41'].fc_loc_code)
    assert_equal(0,                           lsmap.data['vfchost41'].ports_logged_in)
    assert_equal('4<NOT_LOGGED>',             lsmap.data['vfchost41'].flags)
    assert_equal('',                          lsmap.data['vfchost41'].vfc_client_name)
    assert_equal('',                          lsmap.data['vfchost41'].vfc_client_drc)

  end

  # test data source: https://www.ibm.com/developerworks/aix/library/au-NPIV/index.html
  def test_npiv_for_lpar
    string = 'Name          Physloc                            ClntID ClntName       ClntOS
------------- ---------------------------------- ------ -------------- -------
vfchost0      U8233.E8B.XXXXXXX-V1-C66                4 LPAR4          AIX

Status:LOGGED_IN
FC name:fcs0                    FC loc code:U78A0.001.XXXXXXX-P1-C3-T1
Ports logged in:5
Flags:a<LOGGED_IN,STRIP_MERGE>
VFC client name:fcs0            VFC client DRC:U8233.E8B.XXXXXXX-V6-C30-T1

Name          Physloc                            ClntID ClntName       ClntOS
------------- ---------------------------------- ------ -------------- -------
vfchost1      U8233.E8B.XXXXXXX-V1-C67                4 LPAR4          AIX

Status:LOGGED_IN
FC name:fcs1                    FC loc code:U78A0.001.XXXXXXX-P1-C3-T2
Ports logged in:5
Flags:a<LOGGED_IN,STRIP_MERGE>
VFC client name:fcs1            VFC client DRC:U8233.E8B.XXXXXXX-V6-C31-T1

Name          Physloc                            ClntID ClntName       ClntOS
------------- ---------------------------------- ------ -------------- -------
vfchost3      U8233.E8B.XXXXXXX-V1-C30                3 nim1           AIX

Status:LOGGED_IN
FC name:fcs2                    FC loc code:U5877.001.XXXXXXX-P1-C1-T1
Ports logged in:5
Flags:a<LOGGED_IN,STRIP_MERGE>
VFC client name:fcs0            VFC client DRC:U8233.E8B.XXXXXXX-V3-C30-T1

Name          Physloc                            ClntID ClntName       ClntOS
------------- ---------------------------------- ------ -------------- -------
vfchost4      U8233.E8B.XXXXXXX-V1-C31                3 nim1           AIX

Status:LOGGED_IN
FC name:fcs3                    FC loc code:U5877.001.XXXXXXX-P1-C1-T2
Ports logged in:5
Flags:a<LOGGED_IN,STRIP_MERGE>
VFC client name:fcs1            VFC client DRC:U8233.E8B.XXXXXXX-V3-C31-T1'
    lsmap = Lsmap_npiv.new(string)

    lsmap_lpar3 = lsmap.mapping_for_lpar_id(3)
    assert_equal(2, lsmap_lpar3.count)
  end


end
