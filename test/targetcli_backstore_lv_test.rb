$LOAD_PATH << File.dirname(__FILE__)+"./lib"
$LOAD_PATH << File.dirname(__FILE__)

require 'Targetcli/Backstore'
require 'Targetcli/Backstore_block'
require 'Targetcli/Backstore_block_lv'
require 'test/unit'


class TestTargetcli < Test::Unit::TestCase

	def test1 
	
		testcli = Backstore_block_lv.new

		string='No such path /backstores/block/aix1_1_lv2'
		assert_equal("no device", testcli.lsDecode(string))
		
		string2 = '| | o- aix1_1_lv .............................................................. [/dev/iscsi_vg/aix1_1_lv (10.0GiB) write-thru activated]'
		assert_equal('device found', testcli.lsDecode(string2))

		assert_equal('aix1_1_lv', testcli.name)
		assert_equal('iscsi_vg', testcli.vg)
		assert_equal('aix1_1_lv', testcli.lv)
		assert_equal('10.0GiB', testcli.size)
		assert_equal('write-thru', testcli.write)
		assert_equal('activated', testcli.status)
		assert_equal('/dev/iscsi_vg/aix1_1_lv', testcli.path)
		
	end

	def test_create_cmd

		testcli = Backstore_block_lv.new
		testcli.vg='iscsi_vg'
		testcli.lv = 'aix1_1_lv'
		testcli.name='aix1_1_lv'
	
		cmd = '/usr/bin/targetcli /backstores/block create name=aix1_1_lv dev=/dev/iscsi_vg/aix1_1_lv'

		assert_equal(cmd, testcli.create_cmd)
		
	end

	def test_delete_cmd

		testcli = Backstore_block_lv.new
		testcli.name="aix1_1_lv"
	
		cmd = "/usr/bin/targetcli /backstores/block delete aix1_1_lv"

		assert_equal(cmd, testcli.delete_cmd)
		
	end

	def test_ls_all_cmd

		testcli = Backstore_block_lv.new
	
		cmd = '/usr/bin/targetcli /backstores/block ls'

		assert_equal(cmd, testcli.ls_all_cmd)
		
	end

end