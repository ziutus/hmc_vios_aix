$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'Targetcli'

require "test/unit"


class TestTargetcli < Test::Unit::TestCase

	def test_list_all_1

string = "
o- / ......................................................................................................................... [...]
  o- backstores .............................................................................................................. [...]
  | o- block .................................................................................................. [Storage Objects: 5]
  | | o- aix1_1_lv ........................................................ [/dev/iscsi_vg/aix1_1_lv (10.0GiB) write-thru activated]
  | | o- aix1_2_lv ........................................................ [/dev/iscsi_vg/aix1_2_lv (10.0GiB) write-thru activated]
  | | o- disk1_lv .......................................................... [/dev/iscsi_vg/disk1_lv (10.0GiB) write-thru activated]
  | | o- lpar2_lv .......................................................... [/dev/iscsi_vg/lpar2_lv (36.0MiB) write-thru activated]
  | | o- nim1_1_lv ........................................................ [/dev/iscsi_vg/nim1_1_lv (20.0GiB) write-thru activated]
  | o- fileio ................................................................................................. [Storage Objects: 0]
  | o- pscsi .................................................................................................. [Storage Objects: 0]
  | o- ramdisk ................................................................................................ [Storage Objects: 0]
  o- iscsi ............................................................................................................ [Targets: 1]
  | o- iqn.2016-11.server2.localnet ...................................................................................... [TPGs: 1]
  |   o- tpg1 ..................................................................................... [gen-acls, tpg-auth, 1-way auth]
  |     o- acls .......................................................................................................... [ACLs: 4]
  |     | o- iqn.2016-11.aix2.localnet .............................................................. [auth via tpg, Mapped LUNs: 1]
  |     | | o- mapped_lun0 .............................................................................. [lun4 block/lpar2_lv (rw)]
  |     | o- iqn.2016-11.nim1.localnet .............................................................. [auth via tpg, Mapped LUNs: 1]
  |     | | o- mapped_lun0 .............................................................................. [lun4 block/lpar2_lv (rw)]
  |     | o- iqn.2016-11.vios1.localnet ............................................................. [auth via tpg, Mapped LUNs: 3]
  |     | | o- mapped_lun0 .............................................................................. [lun0 block/disk1_lv (rw)]
  |     | | o- mapped_lun1 ............................................................................. [lun1 block/aix1_1_lv (rw)]
  |     | | o- mapped_lun2 ............................................................................. [lun2 block/aix1_2_lv (rw)]
  |     | o- iqn.2016-11.vios2.localnet ............................................................. [auth via tpg, Mapped LUNs: 3]
  |     |   o- mapped_lun0 .............................................................................. [lun0 block/disk1_lv (rw)]
  |     |   o- mapped_lun1 ............................................................................. [lun1 block/aix1_1_lv (rw)]
  |     |   o- mapped_lun2 ............................................................................. [lun2 block/aix1_2_lv (rw)]
  |     o- luns .......................................................................................................... [LUNs: 5]
  |     | o- lun0 ........................................................................ [block/disk1_lv (/dev/iscsi_vg/disk1_lv)]
  |     | o- lun1 ...................................................................... [block/aix1_1_lv (/dev/iscsi_vg/aix1_1_lv)]
  |     | o- lun2 ...................................................................... [block/aix1_2_lv (/dev/iscsi_vg/aix1_2_lv)]
  |     | o- lun3 ...................................................................... [block/nim1_1_lv (/dev/iscsi_vg/nim1_1_lv)]
  |     | o- lun4 ........................................................................ [block/lpar2_lv (/dev/iscsi_vg/lpar2_lv)]
  |     o- portals .................................................................................................... [Portals: 1]
  |       o- 192.168.200.20:3260 .............................................................................................. [OK]
  o- loopback ......................................................................................................... [Targets: 0]
  o- vhost ............................................................................................................ [Targets: 0]
"

	iscsi = Targetcli.new() 
	
   end
end 
