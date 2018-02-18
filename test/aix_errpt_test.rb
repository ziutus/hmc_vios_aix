$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'AIX/Errpt'
require 'test/unit'
require 'pp'


# noinspection RubyResolve
class TestAixErrptEntry < Test::Unit::TestCase

  #Test data taken from: https://community.aveksa.com/thread/227734?start=0&tstart=0
  def test_errpt1

string='A5E6DB96   0414083416 I S pmig           Client Partition Migration Completed
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

end