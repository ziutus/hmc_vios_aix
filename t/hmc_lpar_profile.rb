$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/Lpar_profile'
require 'HMC/VirtualEthAdapter'
require "test/unit"


class TestHMCLparProfile < Test::Unit::TestCase
 
	#source of data, own Power5 frame
	def test_profile_decode
			string = 'name=normal,lpar_name=nim1,lpar_id=5,lpar_env=aixlinux,all_resources=0,min_mem=2048,desired_mem=6144,max_mem=10240,min_num_huge_pages=0,desired_num_huge_pages=0,max_num_huge_pages=0,mem_mode=ded,hpt_ratio=1:64,proc_mode=shared,min_proc_units=0.1,desired_proc_units=0.3,max_proc_units=0.8,min_procs=1,desired_procs=1,max_procs=2,sharing_mode=cap,uncap_weight=0,io_slots=none,lpar_io_pool_ids=none,max_virtual_slots=10,"virtual_serial_adapters=0/server/1/any//any/1,1/server/1/any//any/1","virtual_scsi_adapters=2/client/2/vios1/2/1,3/client/3/vios2/2/1","virtual_eth_adapters=6/1/6//0/0,7/0/7//0/0",hca_adapters=none,boot_mode=norm,conn_monitoring=0,auto_start=0,power_ctrl_lpar_ids=none,work_group_id=none,redundant_err_path_reporting=0'
		
			profile = Lpar_profile.new("9131-52A-6535CCG", 5, "nim1")
			profile.lssyscfgProfDecode(string)
			
			assert_equal("normal", profile.name)
			assert_equal("nim1",   profile.lpar_name)
			assert_equal(5,        profile.lpar_id)
			assert_equal("aixlinux", profile.lpar_env)
			assert_equal(0,        profile.all_resources)
			assert_equal(2048,     profile.min_mem)
			assert_equal(6144,     profile.desired_mem)
			assert_equal(10240,    profile.max_mem)
			assert_equal("0",        profile.min_num_huge_pages)
			assert_equal("0",        profile.desired_num_huge_pages)
			assert_equal("0",        profile.max_num_huge_pages)
			assert_equal("ded",    profile.mem_mode)
			assert_equal("1:64",   profile.hpt_ratio)
			assert_equal("shared", profile.proc_mode)
			assert_equal(0.1,      profile.min_proc_units)
			assert_equal(0.3,      profile.desired_proc_units)
			assert_equal(0.8,      profile.max_proc_units)
			assert_equal(1,        profile.min_procs)
			assert_equal(1,        profile.desired_procs)
			assert_equal(2,        profile.max_procs)
			assert_equal("cap",    profile.sharing_mode)
			assert_equal(0,		   profile.uncap_weight)
			assert_equal("none",   profile.io_slots_raw)
			assert_equal("none",   profile.lpar_io_pool_ids)
			assert_equal(10,       profile.max_virtual_slots)
			assert_equal("0/server/1/any//any/1,1/server/1/any//any/1", profile.virtual_serial_adapters_raw)
			assert_equal("2/client/2/vios1/2/1,3/client/3/vios2/2/1",   profile.virtual_scsi_adapters_raw)
			assert_equal("6/1/6//0/0,7/0/7//0/0",                       profile.virtual_eth_adapters_raw)

			assert_equal(2, profile.virtual_serial_adapters.count)
			assert_equal(2, profile.virtual_scsi_adapters.count)
			assert_equal(2, profile.virtual_eth_adapters.count)
			assert_equal(0, profile.io_slots.count)

			assert_equal("none", profile.hca_adapters_raw)
			assert_equal("norm", profile.boot_mode)
			assert_equal(0,      profile.conn_monitoring)
			assert_equal(0,      profile.auto_start)
			assert_equal("none", profile.power_ctrl_lpar_ids)
			assert_equal("none", profile.work_group_id)
			assert_equal("0",    profile.redundant_err_path_reporting)

	end

	#source of data, own Power5 frame
	def test_profile_decode_2()

		string = 'name=normal,lpar_name=vios2,lpar_id=3,lpar_env=vioserver,all_resources=0,min_mem=1024,desired_mem=6144,max_mem=10240,mem_mode=ded,hpt_ratio=1:64,proc_mode=shared,min_proc_units=0.1,desired_proc_units=0.3,max_proc_units=0.6,min_procs=1,desired_procs=1,max_procs=1,sharing_mode=cap,uncap_weight=0,"io_slots=21010002/none/1,21050003/none/1",lpar_io_pool_ids=none,max_virtual_slots=200,"virtual_serial_adapters=0/server/1/any//any/1,1/server/1/any//any/1",virtual_scsi_adapters=2/server/5/nim1/3/0,"virtual_eth_adapters=6/0/6//2/1,8/0/8//2/1,9/0/6//0/0",hca_adapters=none,boot_mode=norm,conn_monitoring=0,auto_start=0,power_ctrl_lpar_ids=none,work_group_id=none,redundant_err_path_reporting=0'
		profile = Lpar_profile.new("System", "vios2", 3, "normal")
		profile.lssyscfgProfDecode(string)
		
		assert_equal(profile.name, 							"normal")
		assert_equal(profile.lpar_name,						"vios2")
		assert_equal(profile.lpar_id,						3) 
		assert_equal(profile.lpar_env, 						"vioserver")
		assert_equal(profile.all_resources,					0)
		assert_equal(profile.min_mem,						1024)
		assert_equal(profile.desired_mem,					6144)
		assert_equal(profile.max_mem,						10240)
		assert_equal(profile.mem_mode,						"ded")
		assert_equal(profile.hpt_ratio,						"1:64")
		assert_equal(profile.proc_mode,						"shared")
		assert_equal(profile.min_proc_units,				0.1)
		assert_equal(profile.desired_proc_units,			0.3)
		assert_equal(profile.max_proc_units,				0.6)
		assert_equal(profile.min_procs,						1)
		assert_equal(profile.desired_procs,					1)
		assert_equal(profile.max_procs,						1)
		assert_equal(profile.sharing_mode,					"cap")
		assert_equal(profile.uncap_weight,					0)
		assert_equal(profile.io_slots_raw,					"21010002/none/1,21050003/none/1")
		assert_equal(profile.lpar_io_pool_ids,				"none")
		assert_equal(profile.max_virtual_slots,				200)
		assert_equal("0/server/1/any//any/1,1/server/1/any//any/1", profile.virtual_serial_adapters_raw)
		assert_equal("2/server/5/nim1/3/0",						    profile.virtual_scsi_adapters_raw)
		assert_equal("6/0/6//2/1,8/0/8//2/1,9/0/6//0/0",			profile.virtual_eth_adapters_raw)

		assert_equal(2, profile.virtual_serial_adapters.count)
		assert_equal(1 , profile.virtual_scsi_adapters.count)
		assert_equal(3, profile.virtual_eth_adapters.count)
		assert_equal(0, profile.io_slots.count)

		assert_equal("none", profile.hca_adapters_raw)
		assert_equal("norm", profile.boot_mode)
		assert_equal(0,      profile.conn_monitoring)
		assert_equal(0,      profile.auto_start)
		assert_equal("none", profile.power_ctrl_lpar_ids)
		assert_equal("none", profile.work_group_id)
		assert_equal("0",      profile.redundant_err_path_reporting)		
		
	end 	
	
	#example data from: https://www.ibm.com/developerworks/community/wikis/home?lang=en#!/wiki/Power+Systems/page/HMC+command+line
	def test_profile_decode_3
			string = 'name=normal,lpar_name=op710-1-VIO-Server,lpar_id=1,lpar_env=vioserver,all_resources=0,min_mem=1024,desired_mem=1024,max_mem=2048,proc_mode=shared,min_proc_units=0.1,desired_proc_units=0.2,max_proc_units=1.0,min_procs=1,desired_procs=1,max_procs=10,sharing_mode=uncap,uncap_weight=255,"io_slots=21040002/none/1,21010002/none/1",lpar_io_pool_ids=none,max_virtual_slots=10,"virtual_serial_adapters=1/server/1/any//any/1,0/server/1/any//any/1","virtual_scsi_adapters=4/server/3/op710-1-Client2-RHAS4U3/3/1,6/server/5/op710-1-Client4-openSUSE-10.1/3/1,3/server/2/op710-1-Client1-SLES9SP3/3/1,7/server/6/op710-1-Client5-Fedora-Core-4/3/1,5/server/4/op710-1-Client3-Debian-3.1/3/1",virtual_eth_adapters=2/0/1//1/1,boot_mode=norm,conn_monitoring=1,auto_start=1,power_ctrl_lpar_ids=none,work_group_id=none,redundant_err_path_reporting=null'
		
			profile = Lpar_profile.new("unknown-frame", 1, "op710-1-VIO-Server")
			profile.lssyscfgProfDecode(string)
			
			assert_equal("normal",    profile.name)
			assert_equal("op710-1-VIO-Server", profile.lpar_name)
			assert_equal(1 ,          profile.lpar_id)
			assert_equal('vioserver', profile.lpar_env)
			assert_equal(0,           profile.all_resources)
			assert_equal(1024,        profile.min_mem)
			assert_equal(1024,        profile.desired_mem)
			assert_equal(2048,        profile.max_mem)
			assert_equal('shared',    profile.proc_mode)

			assert_equal(0.1, profile.min_proc_units)
			assert_equal(0.2, profile.desired_proc_units)
			assert_equal(1.0, profile.max_proc_units)
			assert_equal(1,   profile.min_procs)
			assert_equal(1,   profile.desired_procs)
			assert_equal(10,  profile.max_procs)

			assert_equal("uncap", profile.sharing_mode)
			assert_equal(255,     profile.uncap_weight)
			assert_equal('none',  profile.lpar_io_pool_ids)
			assert_equal(10,      profile.max_virtual_slots)
			assert_equal('norm',  profile.boot_mode)
			assert_equal(1,       profile.conn_monitoring)
			assert_equal(1,       profile.auto_start)
			assert_equal('none',  profile.power_ctrl_lpar_ids)
			assert_equal('none',  profile.work_group_id)
			assert_equal('null',  profile.redundant_err_path_reporting)
			
			assert_equal('2/0/1//1/1', profile.virtual_eth_adapters_raw)
			assert_equal('21040002/none/1,21010002/none/1', profile.io_slots_raw)
			assert_equal('1/server/1/any//any/1,0/server/1/any//any/1' , profile.virtual_serial_adapters_raw)
			assert_equal('4/server/3/op710-1-Client2-RHAS4U3/3/1,6/server/5/op710-1-Client4-openSUSE-10.1/3/1,3/server/2/op710-1-Client1-SLES9SP3/3/1,7/server/6/op710-1-Client5-Fedora-Core-4/3/1,5/server/4/op710-1-Client3-Debian-3.1/3/1' , profile.virtual_scsi_adapters_raw)

			assert_equal(1, profile.virtual_eth_adapters.count)
			assert_equal(0, profile.io_slots.count)
			assert_equal(2, profile.virtual_serial_adapters.count)
			assert_equal(5, profile.virtual_scsi_adapters.count)
	
	end	
	
	# source of data: https://sort.veritas.com/public/documents/sfha/6.1/aix/productguides/html/sfhas_virtualization/ch08s05.htm
	def test_profile_decode_4
	
		string = 'name=lpar05,lpar_name=lpar05,lpar_id=15,lpar_env=aixlinux,all_resources=0,min_mem=512,desired_mem=2048,max_mem=4096,min_num_huge_pages=null,desired_num_huge_pages=null,max_num_huge_pages=null,mem_mode=ded,mem_expansion=0.0,hpt_ratio=1:64,proc_mode=ded,min_procs=1,desired_procs=1,max_procs=1,sharing_mode=share_idle_procs,affinity_group_id=none,io_slots=none,lpar_io_pool_ids=none,max_virtual_slots=1000,"virtual_serial_adapters=0/server/1/any//any/1,1/server/1/any//any/1","virtual_scsi_adapters=304/client/2/vio_server1/4/1,404/client/3/vio_server2/6/1","virtual_eth_adapters=10/0/1//0/0/ETHERNET0//all/none,11/0/97//0/0/ETHERNET0//all/none,12/0/98//0/0/ETHERNET0//all/none",vtpm_adapters=none,"virtual_fc_adapters=""504/client/2/vio_server1/8/c050760431670010,c050760431670011/1"",""604/client/3/vio_server2/5/c050760431670012,c050760431670013/1""",hca_adapters=none,boot_mode=norm,conn_monitoring=1,auto_start=0,power_ctrl_lpar_ids=none,work_group_id=none,redundant_err_path_reporting=null,bsr_arrays=0,lhea_logical_ports=none,lhea_capabilities=none,lpar_proc_compat_mode=default,electronic_err_reporting=null'

		profile = Lpar_profile.new("unknown-frame", 15, "lpar05")
		profile.lssyscfgProfDecode(string)
		
		assert_equal('lpar05', profile.name)
		assert_equal('lpar05', profile.lpar_name)
		assert_equal(15, profile.lpar_id)
		assert_equal('aixlinux', profile.lpar_env)
		assert_equal(0, profile.all_resources)
		assert_equal(512, profile.min_mem)
		assert_equal(2048,profile.desired_mem)
		assert_equal(4096, profile.max_mem)
		assert_equal('null', profile.min_num_huge_pages)
		assert_equal('null', profile.desired_num_huge_pages)
		assert_equal('null', profile.max_num_huge_pages)
		assert_equal('ded', profile.mem_mode)
		assert_equal(0.0, profile.mem_expansion)
		assert_equal('1:64', profile.hpt_ratio)
		assert_equal('ded', profile.proc_mode)
		assert_equal(1, profile.min_procs)
		assert_equal(1, profile.desired_procs)
		assert_equal(1, profile.max_procs)
		assert_equal('share_idle_procs', profile.sharing_mode)
		assert_equal('none', profile.affinity_group_id)
		assert_equal('none', profile.io_slots_raw)
		assert_equal('none', profile.lpar_io_pool_ids)
		assert_equal(1000, profile.max_virtual_slots)
		assert_equal('0/server/1/any//any/1,1/server/1/any//any/1', profile.virtual_serial_adapters_raw)
		assert_equal('304/client/2/vio_server1/4/1,404/client/3/vio_server2/6/1', profile.virtual_scsi_adapters_raw)
		assert_equal('10/0/1//0/0/ETHERNET0//all/none,11/0/97//0/0/ETHERNET0//all/none,12/0/98//0/0/ETHERNET0//all/none', profile.virtual_eth_adapters_raw)
		assert_equal('none', profile.vtpm_adapters_raw)
#		assert_equal('""504/client/2/vio_server1/8/c050760431670010,c050760431670011/1"",""604/client/3/vio_server2/5/c050760431670012,c050760431670013/1""', profile.virtual_fc_adapters_raw)
		assert_equal(2, profile.virtual_fc_adapters.count)
		assert_equal('none', profile.hca_adapters_raw)
		assert_equal('norm', profile.boot_mode)
		assert_equal(1, profile.conn_monitoring)
		assert_equal(0, profile.auto_start)
		assert_equal('none', profile.power_ctrl_lpar_ids)
		assert_equal('none', profile.work_group_id)
		assert_equal('null', profile.redundant_err_path_reporting)
		assert_equal(0, profile.bsr_arrays)
		assert_equal('none', profile.lhea_logical_ports_raw)
		assert_equal('none', profile.lhea_capabilities)
		assert_equal('default', profile.lpar_proc_compat_mode)
		assert_equal('null', profile.electronic_err_reporting)		
		
	end
	
	# source of data : own power5 frame 
	def test_profile_decode_5
		string = 'name=test_1,lpar_name=dump,lpar_id=1,lpar_env=aixlinux,all_resources=0,min_mem=1152,desired_mem=3200,max_mem=5248,min_num_huge_pages=0,desired_num_huge_pages=0,max_num_huge_pages=0,mem_mode=ded,hpt_ratio=1:64,proc_mode=shared,min_proc_units=0.1,desired_proc_units=0.2,max_proc_units=0.5,min_procs=1,desired_procs=1,max_procs=1,sharing_mode=cap,uncap_weight=0,io_slots=none,lpar_io_pool_ids=none,max_virtual_slots=10,"virtual_serial_adapters=0/server/1/any//any/1,1/server/1/any//any/1",virtual_scsi_adapters=none,"virtual_eth_adapters=""2/1/1/3,4,5/0/1""",hca_adapters=none,boot_mode=sms,conn_monitoring=1,auto_start=0,power_ctrl_lpar_ids=none,work_group_id=none,redundant_err_path_reporting=0'
		profile = Lpar_profile.new("unknown-frame", 15, "lpar05")
		profile.lssyscfgProfDecode(string)
	end
	
	# source od data: http://www.kfsolutions.nl/2013/03/where-do-all-the-virtual-disks-come-from/
	def test_profile_decode_6
		string = 'name=Default,lpar_name=B8008,lpar_id=8,lpar_env=aixlinux,all_resources=0,min_mem=256,desired_mem=1280,max_mem=4352,min_num_huge_pages=0,desired_num_huge_pages=0,max_num_huge_pages=0,mem_mode=ded,hpt_ratio=1:64,proc_mode=shared,min_proc_units=0.1,desired_proc_units=0.5,max_proc_units=1.0,min_procs=1,desired_procs=2,max_procs=4,sharing_mode=uncap,uncap_weight=128,shared_proc_pool_id=0,shared_proc_pool_name=DefaultPool,affinity_group_id=none,io_slots=none,lpar_io_pool_ids=none,max_virtual_slots=256,"virtual_serial_adapters=0/server/1/any//any/1,1/server/1/any//any/1","virtual_scsi_adapters=2/client/1/B8001/21/1,3/client/2/B8002/21/1",virtual_eth_adapters=10/0/955//0/1/vswitchprod//all/none,vtpm_adapters=none,"virtual_fc_adapters=""4/client/1/B8001/22/c05076058ba7001c,c05076058ba7001d/1"",""5/client/2/B8002/22/c05076058ba7001e,c05076058ba7001f/1""",hca_adapters=none,boot_mode=norm,conn_monitoring=0,auto_start=0,power_ctrl_lpar_ids=none,work_group_id=none,redundant_err_path_reporting=0,bsr_arrays=0,lpar_proc_compat_mode=default,electronic_err_reporting=null'
		profile = Lpar_profile.new("unknown-frame", 8, "B8008")
		profile.lssyscfgProfDecode(string)
	end
	
	# source of data: https://www.ibm.com/developerworks/community/forums/html/threadTopic?id=77777777-0000-0000-0000-000014412555
	def test_profile_decode_7
		string = 'name=bt10_normal,lpar_name=bt10,lpar_id=1,lpar_env=vioserver,all_resources=0,min_mem=1024,desired_mem=1024,max_mem=2048,mem_mode=ded,proc_mode=shared,min_proc_units=0.1,desired_proc_units=0.1,max_proc_units=0.5,min_procs=1,desired_procs=1,max_procs=1,sharing_mode=cap,uncap_weight=0,shared_proc_pool_id=0,shared_proc_pool_name=DefaultPool,"io_slots=21010200/none/1,21010201/none/1,21010204/none/1,21010205/none/1,21010207/none/1",lpar_io_pool_ids=none,max_virtual_slots=64,"virtual_serial_adapters=0/server/1/any//any/1,1/server/1/any//any/1",virtual_scsi_adapters=none,virtual_eth_adapters=none,hca_adapters=none,boot_mode=norm,conn_monitoring=0,auto_start=0,power_ctrl_lpar_ids=none,work_group_id=none,redundant_err_path_reporting=0,bsr_arrays=0,virtual_vasi_adapters=none,"lhea_logical_ports=23000000/1/0/1/none,23000000/1/1/9/none",lhea_capabilities=23000000/0,lpar_proc_compat_mode=default,"virtual_fc_adapters=21/server/10/bt11/21//0,22/server/10/bt11/22//0"'
		profile = Lpar_profile.new("unknown-frame", 1, "bt10")
		profile.lssyscfgProfDecode(string)
	end
		
	# source of data: https://chmod666.org/2014/11/configuration-of-a-remote-restart-capable-partition	
	def test_profile_decode_8
		string = 'name=default_profile,lpar_name=temp3-b642c120-00000133,lpar_id=11,lpar_env=aixlinux,all_resources=0,min_mem=8192,desired_mem=8192,max_mem=8192,min_num_huge_pages=0,desired_num_huge_pages=0,max_num_huge_pages=0,mem_mode=ded,mem_expansion=0.0,hpt_ratio=1:128,proc_mode=shared,min_proc_units=2.0,desired_proc_units=2.0,max_proc_units=2.0,min_procs=4,desired_procs=4,max_procs=4,sharing_mode=uncap,uncap_weight=128,shared_proc_pool_id=0,shared_proc_pool_name=DefaultPool,affinity_group_id=none,io_slots=none,lpar_io_pool_ids=none,max_virtual_slots=64,"virtual_serial_adapters=0/server/1/any//any/1,1/server/1/any//any/1",virtual_scsi_adapters=3/client/2/vios1/32/0,virtual_eth_adapters=32/0/1659//0/0/switcha/facc157c3e20/all/0,virtual_eth_vsi_profiles=none,"virtual_fc_adapters=""2/client/1/vios2/32/c050760727c5007a,c050760727c5007b/0"",""4/client/1/vios1/35/c050760727c5007c,c050760727c5007d/0"",""5/client/2/vios2/34/c050760727c5007e,c050760727c5007f/0"",""6/client/2/vios2/35/c050760727c50080,c050760727c50081/0""",vtpm_adapters=none,hca_adapters=none,boot_mode=norm,conn_monitoring=1,auto_start=0,power_ctrl_lpar_ids=none,work_group_id=none,redundant_err_path_reporting=0,bsr_arrays=0,lpar_proc_compat_mode=default,electronic_err_reporting=null,sriov_eth_logical_ports=none'
		profile = Lpar_profile.new("unknown-frame", 11, "temp3-b642c120-00000133")
		profile.lssyscfgProfDecode(string)
	end
		
	def test_profile_decode_9
		string = 'name=p590n22 normal,lpar_name=p590n22,lpar_id=22,lpar_env=aixlinux,all_resources=0,min_mem=1024,desired_mem=4608,max_mem=6144,proc_mode=shared,min_proc_units=1.0,desired_proc_units=1.0,max_proc_units=4.0,min_procs=1,desired_procs=1,max_procs=8,sharing_mode=uncap,uncap_weight=128,"io_slots=2104001C/none/1,21020025/none/1,21040025/none/1,21010020/none/1,21030025/none/1",lpar_io_pool_ids=none,max_virtual_slots=10,"virtual_serial_adapters=1/server/1/any//any/1,0/server/1/any//any/1","virtual_scsi_adapters=2/client/1/p590v01/22/0,3/client/2/p590v02/22/0",virtual_eth_adapters=none,sni_device_ids=none,hca_adapters=none,boot_mode=norm,conn_monitoring=1,auto_start=0,power_ctrl_lpar_ids=none,work_group_id=none,redundant_err_path_reporting=null'
		profile = Lpar_profile.new("unknown-frame", 22, "p590n22")
		profile.lssyscfgProfDecode(string)
	end 
		
	# data source: own Power5 frame
	def test_create_lpar_profile_1
	
		vent1 = VirtualEthAdapter.new()
		vent1.virtualSlotNumber=2
		vent1.portVlanID=1

		vent2 = VirtualEthAdapter.new()
		vent2.virtualSlotNumber=3
		vent2.portVlanID=2
	
		vscsi1 = VirtualScsiAdapter.new()
		vscsi1.virtualSlotNumber=4
		vscsi1.clientOrServer="client"
		vscsi1.remoteLparID=2
		vscsi1.remoteLparName="vios1"
		vscsi1.remoteSlotNumber=11
		vscsi1.isRequired=1
	
		vscsi2 = VirtualScsiAdapter.new()
		vscsi2.virtualSlotNumber=5
		vscsi2.clientOrServer="client"
		vscsi2.remoteLparID=3
		vscsi2.remoteLparName="vios2"
		vscsi2.remoteSlotNumber=12
		vscsi2.isRequired=1	
	
		lpar = Lpar_profile.new('test_frame', 'test_lpar', 10)
		lpar.adapter_eth_add(vent1)
		lpar.adapter_eth_add(vent2)
		
		lpar.adapter_scsi_add(vscsi1)
		lpar.adapter_scsi_add(vscsi2)
	
		command='mksyscfg -r lpar -m test_frame -i "name=test_lpar,lpar_id=10,profile_name=normal,lpar_env=aixlinux,shared_proc_pool_util_auth=1,min_mem=512,desired_mem=2048,max_mem=4096,proc_mode=shared,min_proc_units=0.1,desired_proc_units=0.2,max_proc_units=2.0,min_procs=1,desired_procs=2, max_procs=3,sharing_mode=uncap,uncap_weight=128,boot_mode=norm,conn_monitoring=1,shared_proc_pool_util_auth=1,lpar_io_pool_ids=none,max_virtual_slots=20,io_slots=none,"\"virtual_eth_adapters=2/0/1//0/0,3/0/2//0/0"\","\"virtual_scsi_adapters=4/client/2/vios1/11/1,5/client/3/vios2/12/1"\""'
#		lpar.get_mksyscfg
		assert_equal(command, lpar.get_mksyscfg)

	end
	
end			
		