$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__)+'./lib'

require 'test/unit'
require 'HMC/lspartition_dlpar'

class HmcLspartitionDlparTest < Test::Unit::TestCase

  def test_1
    # data source from https://www.ibm.com/support/knowledgecenter/en/POWER8/p8hc3/p8hc3_hmcpreprmc.htm
    # changed IP only to have more real data
    string='<#0> Partition:<5*8203-E4A*1000xx, servername1.austin.ibm.com, 192.168.100.101>
Active:<0>, OS:< , , >, DCaps:<0x2f>, CmdCaps:<0x0b, 0x0b>, PinnedMem:<0>
<#1> Partition:<4*8203-E4A*10006xx, servername2.austin.ibm.com, 192.168.100.102>
Active:<0>, OS:<AIX>, DCaps:<0x2f>, CmdCaps:<0x0b, 0x0b>, PinnedMem:<0>
<#2> Partition:<3*8203-E4A*10006xx, servername3.austin.ibm.com, 192.168.100.103>
Active:<1>, OS:<AIX>, DCaps:<0x2f>, CmdCaps:<0x0b, 0x0b>, PinnedMem:<340>
<#4> Partition:<5*8203-E4A*10006xx, servername4.austin.ibm.com, 192.168.100.104>
Active:<1>, OS:<AIX>, DCaps:<0x2f>, CmdCaps:<0x0b, 0x0b>, PinnedMem:<140>
'

    lspartition = LspartitionDlpar.new(string)


   # pp lspartition.data

  end
end