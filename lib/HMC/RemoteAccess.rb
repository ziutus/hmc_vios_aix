class RemoteAccess

  attr_reader :ssh
  attr_reader :sshprotocol
  attr_reader :remotewebui
  attr_reader :xntp
  attr_reader :xntpserver
  attr_reader :syslogserver
  attr_reader :syslogtcpserver
  attr_reader :syslogtlsserver
  attr_reader :altdiskboot
  attr_reader :ldap
  attr_reader :kerberos
  attr_reader :kerberos_default_realm
  attr_reader :kerberos_realm_kdc
  attr_reader :kerberos_clockskew
  attr_reader :kerberos_ticket_lifetime
  attr_reader :kpasswd_admin
  attr_reader :trace
  attr_reader :kerberos_keyfile_present
  attr_reader :kerberos_allow_weak_crypto
  attr_reader :legacyhmccomm
  attr_reader :security
  attr_reader :sol


  def initialize(string)
    parse(string) unless string.empty?
  end

  def parse(string)

    regexp = %r{ssh=(enable|disable),
sshprotocol=(|\d),
remotewebui=(enable|disable),
xntp=(enable|disable),
xntpserver=(.*?),
syslogserver=(.*?),
syslogtcpserver=(.*?),
syslogtlsserver=(.*?),
altdiskboot=(enable|disable),
ldap=(enable|disable),
kerberos=(enable|disable),
kerberos_default_realm=(.*?),
kerberos_realm_kdc=(.*?),
kerberos_clockskew=(.*?),
kerberos_ticket_lifetime=(.*?),
kpasswd_admin=(.*?),
trace=(.*?),
kerberos_keyfile_present=(.*?),
kerberos_allow_weak_crypto=(.*?),
legacyhmccomm=(enable|disable),
security=(legacy),
sol=(enabled|disabled)
}x

    match = regexp.match(string)

    if match
      @ssh         = match[1]
      @sshprotocol = match[2]
      @remotewebui = match[3]
      @xntp = match[4]
      @xntpserver = match[5]
      @syslogserver = match[6]
      @syslogtcpserver = match[7]
      @syslogtlsserver = match[8]
      @altdiskboot = match[9]
      @ldap = match[10]
      @kerberos = match[11]
      @kerberos_default_realm = match[12]
      @kerberos_realm_kdc = match[13]
      @kerberos_clockskew = match[14]
      @kerberos_ticket_lifetime = match[15]
      @kpasswd_admin = match[16]
      @trace = match[17]
      @kerberos_keyfile_present = match[18]
      @kerberos_allow_weak_crypto = match[19]
      @legacyhmccomm = match[20]
      @security = match[21]
      @sol = match[22]

    else
      puts string
      puts regexp
      puts match
      puts "regexp couldn't decode string #{string}"
      raise
    end
  end

end