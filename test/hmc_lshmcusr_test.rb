$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'test/unit'
require 'HMC/lshmcusr'

class LsHmcUsrTest < Test::Unit::TestCase


  #data source: comment on article on https://www.ibm.com/developerworks/community/blogs/aixpert/entry/remote_access_control_for_new?lang=en
  def test_1

    string = 'name=someuserid,taskrole=hmcsuperadmin,description=some_security_comment; ,pwage=90,resourcerole=ALL:,authentication_type=local,remote_webui_access=0,remote_ssh_access=1,min_pwage=0,session_timeout=0,verify_timeout=15,idle_timeout=0,inactivity_expiration=0,resources=<ResourceID = ALL:><UserDefinedName = AllSystemResources>,password_encryption=md5,disabled=0'

    user = Lshmcusr.new(string)

#    pp user
    assert_equal('someuserid', user.name)
    assert_equal('hmcsuperadmin',user.taskrole)
    assert_equal('some_security_comment; ',user.description)
    assert_equal(90,user.pwage)
    assert_equal('ALL:',user.resourcerole)
    assert_equal('local',user.authentication_type)
    assert_equal(0,user.remote_webui_access)
    assert_equal(1,user.remote_ssh_access)
    assert_equal(0,user.min_pwage)
    assert_equal(0,user.session_timeout)
    assert_equal(15,user.verify_timeout)
    assert_equal(0,user.idle_timeout)
    assert_equal(0, user.inactivity_expiration)
    assert_equal('<ResourceID = ALL:><UserDefinedName = AllSystemResources>',user.resources)
    assert_equal('md5',user.password_encryption)
    assert_equal(0,user.disabled)

  end
end