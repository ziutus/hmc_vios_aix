class Curl

  attr_reader :serverCertificate


  def initialize string=''

    @serverCertificate = Hash.new

    if string.length > 0
      self.parse(string)
    end

  end

  def parse(string)

    self.getCertInfo(string)
  end


    # * Server certificate:
  #     *       subject: CN=www.google.com,O=Google Inc,L=Mountain View,ST=California,C=US
  # *       start date: Jan 10 09:39:00 2018 GMT
  # *       expire date: Apr 04 09:39:00 2018 GMT
  # *       common name: www.google.com
  # *       issuer: CN=Google Internet Authority G2,O=Google Inc,C=US


  def getCertInfo(string)

      regexp = %r{\*\sServer\scertificate:\s+
\s+\*\s+subject:\s+(CN=[\w\.]+,O=[\w\s]+,L=[\w\s]+,ST=\w+,C=\w{2})\s+
\s+\*\s+start\s+date:\s+(Jan 10 09:39:00 2018 GMT)\s+
\s+\*\s+expire\s+date:\s+(Apr 04 09:39:00 2018 GMT)\s+
\s+\*\s+common\s+name:\s+(\w+)\s+
\s+\*\s+issuer:\s+(CN=[\w\.]+,C=\w{2})\s+}x

      match = regexp.match(string)

      if match
        @serverCertificate['subject']     = match[1]
        @serverCertificate['start date']  = match[2]
        @serverCertificate['expire date'] = match[3]
        @serverCertificate['common name'] = match[4]
        @serverCertificate['issuer']      = match[5]

      else
        puts string
        puts regexp
        puts match
        puts "regexp couldn't decode string #{string}"
        raise

      end

  end

end