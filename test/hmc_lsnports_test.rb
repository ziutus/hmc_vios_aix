$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__)+'./lib'

require 'test/unit'
require 'HMC/lsnports'

class HmcLsnportsTest < Test::Unit::TestCase


  #data source: http://nixys.fr/blog/?p=618

  def test_lns
    string = 'name physloc fabric tports aports swwpns awwpns
fcs0 U5803.001.9SS99BC-P2-C6-T1 1 64 43 2048 1967
fcs1 U5803.001.9SS99BC-P2-C6-T2 1 64 58 2048 2030
fcs4 U5803.001.9SS99BC-P2-C8-T1 1 64 55 2048 2017
fcs5 U5803.001.9SS99BC-P2-C8-T2 1 64 59 2048 2033'

   lsnport = Lsnports.new(string)

    assert_equal(4, lsnport.data.count)

    assert_equal('fcs0', lsnport.data['fcs0']['name'])
    assert_equal('U5803.001.9SS99BC-P2-C6-T1', lsnport.data['fcs0']['physloc'])
    assert_equal(1, lsnport.data['fcs0']['fabric'])
    assert_equal(64, lsnport.data['fcs0']['tports'])
    assert_equal(43, lsnport.data['fcs0']['aports'])
    assert_equal(2048, lsnport.data['fcs0']['swwpns'])
    assert_equal(1967, lsnport.data['fcs0']['awwpns'])

    assert_equal('fcs1', lsnport.data['fcs1']['name'])
    assert_equal('U5803.001.9SS99BC-P2-C6-T2', lsnport.data['fcs1']['physloc'])
    assert_equal(1, lsnport.data['fcs1']['fabric'])
    assert_equal(64, lsnport.data['fcs1']['tports'])
    assert_equal(58, lsnport.data['fcs1']['aports'])
    assert_equal(2048, lsnport.data['fcs1']['swwpns'])
    assert_equal(2030, lsnport.data['fcs1']['awwpns'])


    assert_equal('fcs4', lsnport.data['fcs4']['name'])
    assert_equal('U5803.001.9SS99BC-P2-C8-T1', lsnport.data['fcs4']['physloc'])
    assert_equal(1, lsnport.data['fcs4']['fabric'])
    assert_equal(64, lsnport.data['fcs4']['tports'])
    assert_equal(55, lsnport.data['fcs4']['aports'])
    assert_equal(2048, lsnport.data['fcs4']['swwpns'])
    assert_equal(2017, lsnport.data['fcs4']['awwpns'])

    assert_equal('fcs5', lsnport.data['fcs5']['name'])
    assert_equal('U5803.001.9SS99BC-P2-C8-T2', lsnport.data['fcs5']['physloc'])
    assert_equal(1, lsnport.data['fcs5']['fabric'])
    assert_equal(64, lsnport.data['fcs5']['tports'])
    assert_equal(59, lsnport.data['fcs5']['aports'])
    assert_equal(2048, lsnport.data['fcs5']['swwpns'])
    assert_equal(2033, lsnport.data['fcs5']['awwpns'])

  end
end