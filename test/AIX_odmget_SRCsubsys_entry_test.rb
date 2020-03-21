$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__)+'./lib'

require 'test/unit'
require 'AIX/odmget_srcsubsys_entry'
require 'pp'


class AIX_odmget_SRCsubsys_Test < Test::Unit::TestCase

  # Test data taken from http://www.softpanorama.org/Commercial_unixes/AIX/index.shtml
  def test_lpd

    string='SRCsubsys:
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
        grpname = "spooler"'

    rscsubsys = Odmget_SRCsubsys.new(string)

    assert_equal('lpd', rscsubsys.subsysname, 'lpd - subsysname')
    assert_equal('', rscsubsys.synonym, 'lpd - synonym')
    assert_equal(' ', rscsubsys.cmdargs, 'lpd - cmdargs')
    assert_equal('/usr/lpd/lpd', rscsubsys.path, 'lpd - path')
    assert_equal(0, rscsubsys.uid, 'lpd - uid')
    assert_equal(0, rscsubsys.auditid, 'lpd - auditid')
    assert_equal('/dev/console', rscsubsys.standin, 'lpd - standin')
    assert_equal('/dev/console', rscsubsys.standout, 'lpd - standout')
    assert_equal('/dev/console', rscsubsys.standerr, 'lpd - standerr')
    assert_equal(1, rscsubsys.action, 'lpd - action')
    assert_equal(0, rscsubsys.multi, 'lpd - multi')
    assert_equal(3, rscsubsys.contact, 'lpd - contact')
    assert_equal(0, rscsubsys.svrkey, 'lpd - cvrkey')
    assert_equal(0, rscsubsys.svrmtype, 'lpd - svrmtype')
    assert_equal(20, rscsubsys.priority, 'lpd - priority')
    assert_equal(0, rscsubsys.signorm, 'lpd - signorm')
    assert_equal(0, rscsubsys.sigforce, 'lpd - sigforce')
    assert_equal(1, rscsubsys.display, 'lpd - display')
    assert_equal(20, rscsubsys.waittime, 'lpd - waittime')
    assert_equal('spooler', rscsubsys.grpname, 'lpd - grpname')

  end

  # test source: https://it.toolbox.com/question/odm-command-to-change-srcsubsystem-parameters-050510
  def test_ssh
    string = 'SRCsubsys:
  subsysname = "sshd"
  synonym = ""
  cmdargs = "-D"
  path = "/usr/sbin/sshd"
  uid = 0
  auditid = 0
  standin = "/dev/console"
  standout = "/dev/console"
  standerr = "/dev/console"
  action = 1
  multi = 0
  contact = 2
  svrkey = 0
  svrmtype = 0
  priority = 20
  signorm = 15
  sigforce = 9
  display = 1
  waittime = 20
  grpname = "ssh"'

    rscsubsys = Odmget_SRCsubsys.new(string)
    assert_equal('sshd', rscsubsys.subsysname, 'ssh - subsysname')
    assert_equal('', rscsubsys.synonym, 'ssh - synonym')
    assert_equal('-D', rscsubsys.cmdargs, 'ssh - cmdargs')
    assert_equal('/usr/sbin/sshd', rscsubsys.path, 'ssh - path')
    assert_equal(0, rscsubsys.uid, 'ssh - uid')
    assert_equal(0, rscsubsys.auditid, 'ssh - auditid')
    assert_equal('/dev/console', rscsubsys.standin, 'ssh - standin')
    assert_equal('/dev/console', rscsubsys.standout, 'ssh - standout')
    assert_equal('/dev/console', rscsubsys.standerr, 'ssh - standerr')
    assert_equal(1, rscsubsys.action, 'ssh - action')
    assert_equal(0, rscsubsys.multi, 'ssh - multi')
    assert_equal(2, rscsubsys.contact, 'ssh - contact')
    assert_equal(0, rscsubsys.svrkey, 'ssh - svrkey')
    assert_equal(0, rscsubsys.svrmtype, 'ssh - svrmtype')
    assert_equal(20, rscsubsys.priority, 'ssh - priority')
    assert_equal(15, rscsubsys.signorm, 'ssh - signorm')
    assert_equal(9, rscsubsys.sigforce, 'ssh - sigforce')
    assert_equal(1, rscsubsys.display, 'ssh - display')
    assert_equal(20, rscsubsys.waittime, 'ssh - waittime')
    assert_equal('ssh', rscsubsys.grpname, 'ssh - grpname')

  end
end