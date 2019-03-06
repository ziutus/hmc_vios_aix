$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'AIX/packages'
require 'test/unit'
require 'pp'


class AIX_lslpp < Test::Unit::TestCase

  # http://aix-adm.blogspot.com/2014/12/aix-lslpp.html
  def test_lslpp
    string = "X11.Dt:X11.Dt.ToolTalk:6.1.9.0: : :C: :AIX CDE ToolTalk Support : : : : : : :0:0:/:1341
X11.Dt:X11.Dt.bitmaps:6.1.0.0: : :C: :AIX CDE Bitmaps : : : : : : :0:0:/:0748
X11.Dt:X11.Dt.helpinfo:6.1.2.0: : :C: :AIX CDE Help Files and Volumes : : : : : : :0:0:/:0846
mkisofs:mkisofs-1.13-9:1.13-9: : :C:R:Creates an image of an ISO9660 filesystem.: :/bin/rpm -e mkisofs: : : : :1: :/opt/freeware:Thu Mar 31 05:41:05 CDT 2011
osinstall:osinstall-1.6-1:1.6-1: : :C:R:Cross-platform network installer of multiple operating systems.: :/bin/rpm -e osinstall: : : : :0: :(none):Fri Aug 19 12:00:32 CDT 2011
pci.14101103:pci.14101103-CN0120-1:CN0120-1: : :C:R:Microcode for 4-Port 10/100/1000 Base-TX PCI-X Adapter: :/bin/rpm -e pci.14101103: : : : :0: :/etc/microcode:Wed Aug 20 14:55:50 CDT 2008"


    packages = Packages.new(string)

    assert_equal('6.1.9.0', packages.list["X11.Dt.ToolTalk"].level)
    assert_equal('X11.Dt.ToolTalk', packages.list["X11.Dt.ToolTalk"].fileset)
    assert_equal('AIX CDE ToolTalk Support ', packages.list["X11.Dt.ToolTalk"].description)

 #    assert_equal('bos.rte.security', package.fileset)
 #    assert_equal('5.3.1.1', package.level)
 #    assert_equal('Base Security Function', package.description)


  end

end