$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

require 'HMC/RemoteAccess'
require 'test/unit'
require 'pp'


class TestHMCRemoteAccess < Test::Unit::TestCase

  def test_hmc_remote_access

    #Test data are taken from: https://chmod666.org/2014/03/hardware-management-console-be-autonomous-with-upgrade-update-and-use-the-integrated-management-module
    #string = 'ssh=enable,sshprotocol=,remotewebui=enable,xntp=enable,"xntpserver=127.127.1.0,[..]",syslogserver=,netboot=disable,altdiskboot=enable,ldap=enable,kerberos=disable,kerberos_default_realm=,kerberos_realm_kdc=,kerberos_clockskew=,kerberos_ticket_lifetime=,kerberos_keyfile_present=,"sol=disabled"'

    # Test data are a bit modified upper string
    string = 'ssh=enable,sshprotocol=,remotewebui=enable,xntp=disable,xntpserver=127.127.1.0,syslogserver=,syslogtcpserver=,syslogtlsserver=,altdiskboot=disable,ldap=disable,kerberos=disable,kerberos_default_realm=,kerberos_realm_kdc=,kerberos_clockskew=,kerberos_ticket_lifetime=,kpasswd_admin=,trace=,kerberos_keyfile_present=,kerberos_allow_weak_crypto=,legacyhmccomm=disable,security=legacy,sol=disabled'

    hmc = RemoteAccess.new(string)

    assert_equal('enable',      hmc.ssh)
    assert_equal('',            hmc.sshprotocol)
    assert_equal('enable',      hmc.remotewebui)
    assert_equal('disable',     hmc.xntp)
    assert_equal('127.127.1.0', hmc.xntpserver)
    assert_equal('',            hmc.syslogserver)
    assert_equal('',            hmc.syslogtcpserver)
    assert_equal('',            hmc.syslogtlsserver)
    assert_equal('disable',     hmc.altdiskboot)
    assert_equal('disable',     hmc.ldap)
    assert_equal('disable',     hmc.kerberos)
    assert_equal('',            hmc.kerberos_default_realm)
    assert_equal('',            hmc.kerberos_realm_kdc)
    assert_equal('',            hmc.kerberos_clockskew)
    assert_equal('',            hmc.kerberos_ticket_lifetime)
    assert_equal('',            hmc.kpasswd_admin)
    assert_equal('',            hmc.trace)
    assert_equal('',            hmc.kerberos_keyfile_present)
    assert_equal('',            hmc.kerberos_allow_weak_crypto)
    assert_equal('disable',     hmc.legacyhmccomm)
    assert_equal('legacy',      hmc.security)
    assert_equal('disabled',    hmc.sol)

  end
end
