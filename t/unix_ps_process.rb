$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'Unix/Ps_process'
require "test/unit"
require "pp"




class TestAixEtcHosts < Test::Unit::TestCase

	def test_ps_process_1
		string="root      1206     2  0 Aug19 ?        00:00:00 [xcopy_wq]"

		process = Ps_process.new(string)
		assert_equal("root",  process.uid,  "UID")
		assert_equal(1206,    process.pid,  "PID")
		assert_equal(2,       process.ppid, "PPID")
		assert_equal(0,       process.c,    "C")
		assert_equal("Aug19", process.stime, "STIME")
		assert_equal("?",     process.tty,   "tty")
		assert_equal("00:00:00",   process.time,    "TIME")
		assert_equal("[xcopy_wq]", process.cmd,   "cmd - command full")
	end
	
	def test_ps_process_2
		string="btsync    1207     1 10 Aug19 ?        3-11:06:52 /usr/bin/btsync --config /etc/btsync/config.json"

		process = Ps_process.new(string)
		assert_equal("btsync",  process.uid,  "UID")
		assert_equal(1207,    process.pid,  "PID")
		assert_equal(1,       process.ppid, "PPID")
		assert_equal(10,       process.c,    "C")
		assert_equal("Aug19", process.stime, "STIME")
		assert_equal("?",     process.tty,   "tty")
		assert_equal("3-11:06:52",   process.time,    "TIME")
		assert_equal("/usr/bin/btsync --config /etc/btsync/config.json", process.cmd,   "cmd - command full")
	end

	def test_ps_process_3
		string="ziutus   10208 10206  0 19:25 pts/2    00:00:00 bash -rcfile .bashrc"

		process = Ps_process.new(string)
		assert_equal("ziutus",  process.uid,  "UID")
		assert_equal(10208,    process.pid,  "PID")
		assert_equal(10206,       process.ppid, "PPID")
		assert_equal(0,       process.c,    "C")
		assert_equal("19:25", process.stime, "STIME")
		assert_equal("pts/2",     process.tty,   "tty")
		assert_equal("00:00:00",   process.time,    "TIME")
		assert_equal("bash -rcfile .bashrc", process.cmd,   "cmd - command full")
	end 
	
	# example from: https://serverfault.com/questions/76263/how-to-kill-a-defunct-process-with-parent-1
	def test_ps_process_4
		string='root      5825     1  0 Oct18 ?        00:00:00 [bacula-sd] <defunct>'

		process = Ps_process.new(string)
		assert_equal("root",  process.uid,  "UID")
		assert_equal(5825,    process.pid,  "PID")
		assert_equal(1,       process.ppid, "PPID")
		assert_equal(0,       process.c,    "C")
		assert_equal("Oct18", process.stime, "STIME")
		assert_equal("?",     process.tty,   "tty")
		assert_equal("00:00:00",   process.time,    "TIME")
		assert_equal("[bacula-sd] <defunct>", process.cmd,   "cmd - command full")
	end 

	# example from: http://www.tek-tips.com/viewthread.cfm?qid=673505
	# b2rf1 2736222 1814664   0           0:00 <defunct>
	def test_ps_process_aix_defunct
		string='b2rf1 2736222 1814664   0           0:00 <defunct>'

		process = Ps_process.new(string)
		assert_equal("b2rf1",  process.uid,  "UID")
		assert_equal(2736222,    process.pid,  "PID")
		assert_equal(1814664,       process.ppid, "PPID")
		assert_equal(0,       process.c,    "C")
		assert_equal("", process.stime, "STIME")
		assert_equal("",     process.tty,   "tty")
		assert_equal("0:00",   process.time,    "TIME")
		assert_equal("<defunct>", process.cmd,   "cmd - command full")
	end 
	
	
end
