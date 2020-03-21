$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__)+'./lib'

require 'test/unit'
require 'AIX/odmget'
require 'pp'

require 'test/unit'

class AIX_odmget_SRCsubsys_test < Test::Unit::TestCase


  # Fake test
  def test_multi_src

    string = 'SRCsubsys:
        subsysname = "lpd"
        synonym = ""
        cmdargs = " "
        path = "/usr/lpd/lpd"
        uid = 0
        auditid = 0
        standin = "/dev/console"
        standout = "/dev/console"
        standerr = "/dev/console"
        action = 1
        multi = 0
        contact = 3
        svrkey = 0
        svrmtype = 0
        priority = 20
        signorm = 0
        sigforce = 0
        display = 1
        waittime = 20
        grpname = "spooler"
SRCsubsys:
        subsysname = "inetd"
        synonym = ""
        cmdargs = ""
        path = "/etc/inetd"
        uid = 0
        auditid = 0
        standin = "/dev/console"
        standout = "/dev/console"
        standerr = "/dev/console"
        action = 2
        multi = 0
        contact = 3
        svrkey = 0
        svrmtype = 0
        priority = 20
        signorm = 0
        sigforce = 0
        display = 1
        waittime = 20
        grpname = "tcpip"'

    odm = Odmget.new(string)

#    pp odm

  end
end