$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__)+'./lib'

require 'AIX/Errpt'
require 'test/unit'
require 'pp'


# noinspection RubyResolve
class TestAixErrptEntry < Test::Unit::TestCase

  # Test data taken from: https://community.aveksa.com/thread/227734?start=0&tstart=0
  def test_errpt1

    string = 'A5E6DB96   0414083416 I S pmig           Client Partition Migration Completed
1BBD20F4   0414083416 I H hdiskpower3    FUNCTION DEGRADED
C6E26F3B   0414083416 I H hdisk19        BACK-UP PATH STATUS CHANGE
1E67811B   0414083316 P H hdisk19        UNABLE TO COMMUNICATE WITH DEVICE
516A2BC4   0414083316 P H hdisk9         CONNECTION FAILURE
516A2BC4   0414083316 P H hdisk1         CONNECTION FAILURE
516A2BC4   0414083316 P H hdisk14        CONNECTION FAILURE
516A2BC4   0414083316 P H hdisk19        CONNECTION FAILURE
516A2BC4   0414083316 P H hdisk17        CONNECTION FAILURE
516A2BC4   0414083316 P H hdisk6         CONNECTION FAILURE
516A2BC4   0414083316 P H hdisk2         CONNECTION FAILURE
516A2BC4   0414083316 P H hdisk12        CONNECTION FAILURE
516A2BC4   0414083316 P H hdisk13        CONNECTION FAILURE
516A2BC4   0414083316 P H hdisk5         CONNECTION FAILURE
516A2BC4   0414083316 P H hdisk16        CONNECTION FAILURE
516A2BC4   0414083316 P H hdisk18        CONNECTION FAILURE
516A2BC4   0414083316 P H hdisk11        CONNECTION FAILURE
516A2BC4   0414083316 P H hdisk0         CONNECTION FAILURE
516A2BC4   0414083316 P H hdisk8         CONNECTION FAILURE
08917DC6   0414083316 I S pmig           Client Partition Migration Started'

    errpt = Errpt.new(string)


#    pp errpt
  end

  # Test data created using information from: https://www.ibm.com/developerworks/community/blogs/KRblog/entry/powerha_and_powerpath_error_notification?lang=en_us

  # The errpt source: http://ahix.fr/index.php/107-documentations/pseries-p6/vio-serveur/installation/705-npiv-implantation-et-validation
  def test_powerpath2
    string = 'IDENTIFIER TIMESTAMP T C RESOURCE_NAME DESCRIPTION
D712FEAE   0726162611 T S fcs0          LINK_DEAD events reported by the VIOS
26623394   0726162111 T H fscsi0         COMMUNICATION PROTOCOL ERROR
4B436A3D   0726162111 T H fscsi0         LINK ERROR
26623394   0726162111 T H fscsi0         COMMUNICATION PROTOCOL ERROR
4B436A3D   0726162111 T H fscsi0         LINK ERROR
26623394   0726162111 T H fscsi0         COMMUNICATION PROTOCOL ERROR
4B436A3D   0726162111 T H fscsi0         LINK ERROR
26623394   0726162111 T H fscsi0         COMMUNICATION PROTOCOL ERROR
4B436A3D   0726162111 T H fscsi0        LINK ERROR
3767AAFF   0726162111 I H hdisk2         BACK-UP PATH INOPERATIVE
516A2BC4   0726162111 P H hdisk2         CONNECTION FAILURE
26623394   0726162111 T H fscsi0         COMMUNICATION PROTOCOL ERROR
4B436A3D   0726162111 T H fscsi0         LINK ERROR
26623394   0726162111 T H fscsi0         COMMUNICATION PROTOCOL ERROR
4B436A3D   0726162111 T H fscsi0         LINK ERROR
3767AAFF   0726162111 I H hdisk3         BACK-UP PATH INOPERATIVE
516A2BC4   0726162111 P H hdisk3         CONNECTION FAILURE
26623394   0726162111 T H fscsi0         COMMUNICATION PROTOCOL ERROR
4B436A3D   0726162111 T H fscsi0         LINK ERROR
26623394   0726162111 T H fscsi0         COMMUNICATION PROTOCOL ERROR
4B436A3D   0726162111 T H fscsi0         LINK ERROR
26623394   0726162111 T H fscsi0         COMMUNICATION PROTOCOL ERROR
4B436A3D   0726162111 T H fscsi0         LINK ERROR
26623394   0726162111 T H fscsi0         COMMUNICATION PROTOCOL ERROR
4B436A3D   0726162111 T H fscsi0         LINK ERROR
26623394   0726162111 T H fscsi0         COMMUNICATION PROTOCOL ERROR
4B436A3D   0726162111 T H fscsi0         LINK ERROR'

    errpt = Errpt.new(string)

  end

  # test data source: https://www.ibm.com/developerworks/community/blogs/paixperiences/entry/vios_npiv_issues?lang=en_us
  def test_vios_1
    string = '7870C5A4   0620125012 T S vfchost12      Virtual FC Host Adapter detected an erro
7870C5A4   0620125012 T S vfchost12      Virtual FC Host Adapter detected an erro
7870C5A4   0620125012 T S vfchost0       Virtual FC Host Adapter detected an erro
7870C5A4   0620125012 T S vfchost0       Virtual FC Host Adapter detected an erro'

    errpt = Errpt.new(string)
    errpt.summary

    pp errpt.errors_summary

    assert_equal(4, errpt.errors.count, 'number of errors in errpt')

  end

  def test_compare
    entry1 = ErrptEntry.new('7870C5A4   0620125012 T S vfchost12      Virtual FC Host Adapter detected an erro')
    entry2 = ErrptEntry.new('7870C5A4   0620125012 T S vfchost12      Virtual FC Host Adapter detected an erro')
    entry3 = ErrptEntry.new('7870C5A4   0620125012 T S vfchost0       Virtual FC Host Adapter detected an erro')
    entry4 = ErrptEntry.new('4B436A3D   0726162111 T H fscsi0         LINK ERROR')

    assert_equal(true, entry1.compare_short(entry2))
    assert_equal(false, entry1.compare_short(entry3))
    assert_equal(false, entry1.compare_short(entry4))

  end

end