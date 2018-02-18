$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'test/unit'

class CurCertTest < Test::Unit::TestCase


  # Fake test
  def test_no_ssl

    # source: [ziutus@server2 ~]$ curl --insecure -v http://www.google.com
    string = '
* Rebuilt URL to: http://www.google.com/
*   Trying 172.217.16.4...
* Connected to www.google.com (172.217.16.4) port 80 (#0)
> GET / HTTP/1.1
> Host: www.google.com
> User-Agent: curl/7.47.1
> Accept: */*
>
< HTTP/1.1 302 Found
< Cache-Control: private
< Content-Type: text/html; charset=UTF-8
< Referrer-Policy: no-referrer
< Location: http://www.google.pl/?gfe_rd=cr&dcr=0&ei=NJVqWsO8IuKkX5mUj-AE
< Content-Length: 266
< Date: Fri, 26 Jan 2018 02:40:52 GMT
<
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>302 Moved</TITLE></HEAD><BODY>
<H1>302 Moved</H1>
The document has moved
<A HREF="http://www.google.pl/?gfe_rd=cr&amp;dcr=0&amp;ei=NJVqWsO8IuKkX5mUj-AE">here</A>.
</BODY></HTML>
* Connection #0 to host www.google.com left intact
'


#    fail('Not implemented')
  end

 def cert_exist_issuer_exist_test

   #source: [ziutus@server2 ~]$ curl --insecure -v https://www.google.com
   string = '
* Rebuilt URL to: https://www.google.com/
*   Trying 172.217.16.4...
* Connected to www.google.com (172.217.16.4) port 443 (#0)
* Initializing NSS with certpath: sql:/etc/pki/nssdb
* skipping SSL peer certificate verification
* ALPN, server accepted to use h2
* SSL connection using TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
* Server certificate:
*       subject: CN=www.google.com,O=Google Inc,L=Mountain View,ST=California,C=US
*       start date: Jan 10 09:39:00 2018 GMT
*       expire date: Apr 04 09:39:00 2018 GMT
*       common name: www.google.com
*       issuer: CN=Google Internet Authority G2,O=Google Inc,C=US
* Using HTTP2, server supports multi-use
* Connection state changed (HTTP/2 confirmed)
* TCP_NODELAY set
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
* Using Stream ID: 1 (easy handle 0x7b44afe9f0)
> GET / HTTP/1.1
> Host: www.google.com
> User-Agent: curl/7.47.1
> Accept: */*
>
* Connection state changed (MAX_CONCURRENT_STREAMS updated)!
< HTTP/2.0 302
< cache-control:private
< content-type:text/html; charset=UTF-8
< referrer-policy:no-referrer
< location:https://www.google.pl/?gfe_rd=cr&dcr=0&ei=PpVqWuz5D_SkX-bKlnA
< content-length:266
< date:Fri, 26 Jan 2018 02:41:02 GMT
< alt-svc:hq=":443"; ma=2592000; quic=51303431; quic=51303339; quic=51303338; quic=51303337; quic=51303335,quic=":443"; ma=2592000; v="41,39,38,37,35"
<
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>302 Moved</TITLE></HEAD><BODY>
<H1>302 Moved</H1>
The document has moved
<A HREF="https://www.google.pl/?gfe_rd=cr&amp;dcr=0&amp;ei=PpVqWuz5D_SkX-bKlnA">here</A>.
</BODY></HTML>
* Connection #0 to host www.google.com left intact
'

   

  # fail('test not implemented')
 end

  def host_down_test
    string ='[ziutus@server2 ~]$ curl --insecure -v https://192.168.200.5
* Rebuilt URL to: https://192.168.200.5/
*   Trying 192.168.200.5...
* connect to 192.168.200.5 port 443 failed: No route to host
* Failed to connect to 192.168.200.5 port 443: No route to host
* Closing connection 0
curl: (7) Failed to connect to 192.168.200.5 port 443: No route to host
'

   # fail('test not implemented')

  end

end