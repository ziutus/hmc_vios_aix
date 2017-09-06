$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/RemoteAccess'
require "test/unit"
require 'pp'


class TestHMCRemoteAccess < Test::Unit::TestCase

  def test_hmcRemoteAccess

    #Test data are taken from: https://chmod666.org/2014/03/hardware-management-console-be-autonomous-with-upgrade-update-and-use-the-integrated-management-module
    #string = 'ssh=enable,sshprotocol=,remotewebui=enable,xntp=enable,"xntpserver=127.127.1.0,[..]",syslogserver=,netboot=disable,altdiskboot=enable,ldap=enable,kerberos=disable,kerberos_default_realm=,kerberos_realm_kdc=,kerberos_clockskew=,kerberos_ticket_lifetime=,kerberos_keyfile_present=,"sol=disabled"'

    # Test data are taken from:
    string = 'ssh=enable,sshprotocol=,remotewebui=enable,xntp=disable,xntpserver=127.127.1.0,syslogserver=,syslogtcpserver=,syslogtlsserver=,altdiskboot=disable,ldap=disable,kerberos=disable,kerberos_default_realm=,kerberos_realm_kdc=,kerberos_clockskew=,kerberos_ticket_lifetime=,kpasswd_admin=,trace=,kerberos_keyfile_present=,kerberos_allow_weak_crypto=,legacyhmccomm=disable,security=legacy,sol=disabled'

    myHmc = RemoteAccess.new(string)

    assert_equal("enable",    myHmc.ssh)
    assert_equal("",          myHmc.sshprotocol)
    assert_equal("enable",    myHmc.remotewebui)
    assert_equal("disable",   myHmc.xntp)
    assert_equal("127.127.1.0", myHmc.xntpserver)
    assert_equal("",            myHmc.syslogserver)
    assert_equal("",            myHmc.syslogtcpserver)
    assert_equal("",            myHmc.syslogtlsserver)
    assert_equal("disable",     myHmc.altdiskboot)
    assert_equal("disable",     myHmc.ldap)
    assert_equal("disable",     myHmc.kerberos)
    assert_equal("",          myHmc.kerberos_default_realm)
    assert_equal("",          myHmc.kerberos_realm_kdc)
    assert_equal("",          myHmc.kerberos_clockskew)
    assert_equal("",          myHmc.kerberos_ticket_lifetime)
    assert_equal("",          myHmc.kpasswd_admin)
    assert_equal("",          myHmc.trace)
    assert_equal("",          myHmc.kerberos_keyfile_present)
    assert_equal("",          myHmc.kerberos_allow_weak_crypto)
    assert_equal("disable",   myHmc.legacyhmccomm)
    assert_equal("legacy",    myHmc.security)
    assert_equal("disabled",  myHmc.sol)


  end




end
