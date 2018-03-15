$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'test/unit'
require 'AIX/stanza'

class CurCertTest < Test::Unit::TestCase

  #source: https://masaos.wordpress.com/tag/mstate-lpar-lsnim/
  def test_stanza1
    string='
curso01:
   class          = machines
   type           = standalone
   connect        = shell
   platform       = chrp
   netboot_kernel = 64
   if1            = network_admin curso01 0
   cable_type1    = N/A
   Cstate         = ready for a NIM operation
   prev_state     = ready for a NIM operation
   Mstate         = currently running
   cpuid          = 00F690DC4C00'

   stanza = Stanza.new(string)

    assert_equal(1,                  stanza.data.count)
    assert_equal(11,                  stanza.data['curso01'].count)

    assert_equal('machines',                  stanza.data['curso01']['class'])
    assert_equal('standalone',                stanza.data['curso01']['type'])
    assert_equal('shell',                     stanza.data['curso01']['connect'])
    assert_equal('chrp',                      stanza.data['curso01']['platform'])
    assert_equal('64',                        stanza.data['curso01']['netboot_kernel'])
    assert_equal('network_admin curso01 0',   stanza.data['curso01']['if1'])
    assert_equal('N/A',                       stanza.data['curso01']['cable_type1'])
    assert_equal('ready for a NIM operation', stanza.data['curso01']['Cstate'])
    assert_equal('ready for a NIM operation', stanza.data['curso01']['prev_state'])
    assert_equal('currently running',         stanza.data['curso01']['Mstate'])
    assert_equal('00F690DC4C00',              stanza.data['curso01']['cpuid'])


  end


  #source: https://tickets.puppetlabs.com/browse/IMAGES-430
  def test_stanza2
    string='acceptance_setup_fb_script:
   class       = resources
   type        = fb_script
   Rstate      = ready for use
   prev_state  = unavailable for use
   location    = /export/nim/fb_script/acceptance_setup.sh
   alloc_count = 2
   server      = master'

    stanza = Stanza.new(string)

    assert_equal(1,                     stanza.data.count)
    assert_equal(7,                     stanza.data['acceptance_setup_fb_script'].count)

    assert_equal('resources',           stanza.data['acceptance_setup_fb_script']['class'])
    assert_equal('fb_script',           stanza.data['acceptance_setup_fb_script']['type'])
    assert_equal('ready for use',       stanza.data['acceptance_setup_fb_script']['Rstate'])
    assert_equal('unavailable for use', stanza.data['acceptance_setup_fb_script']['prev_state'])
    assert_equal('/export/nim/fb_script/acceptance_setup.sh',                  stanza.data['acceptance_setup_fb_script']['location'])
    assert_equal(2,                     stanza.data['acceptance_setup_fb_script']['alloc_count'])
    assert_equal('master',              stanza.data['acceptance_setup_fb_script']['server'])


  end

  # mix of 2 data sources:
  #source: https://masaos.wordpress.com/tag/mstate-lpar-lsnim/
  #source: https://tickets.puppetlabs.com/browse/IMAGES-430
  def test_stanza_12
    string='
curso01:
   class          = machines
   type           = standalone
   connect        = shell
   platform       = chrp
   netboot_kernel = 64
   if1            = network_admin curso01 0
   cable_type1    = N/A
   Cstate         = ready for a NIM operation
   prev_state     = ready for a NIM operation
   Mstate         = currently running
   cpuid          = 00F690DC4C00
acceptance_setup_fb_script:
   class       = resources
   type        = fb_script
   Rstate      = ready for use
   prev_state  = unavailable for use
   location    = /export/nim/fb_script/acceptance_setup.sh
   alloc_count = 2
   server      = master'

    stanza = Stanza.new(string)

    assert_equal(2,                  stanza.data.count)

    assert_equal(11,                          stanza.data['curso01'].count)
    assert_equal('machines',                  stanza.data['curso01']['class'])
    assert_equal('standalone',                stanza.data['curso01']['type'])
    assert_equal('shell',                     stanza.data['curso01']['connect'])
    assert_equal('chrp',                      stanza.data['curso01']['platform'])
    assert_equal('64',                        stanza.data['curso01']['netboot_kernel'])
    assert_equal('network_admin curso01 0',   stanza.data['curso01']['if1'])
    assert_equal('N/A',                       stanza.data['curso01']['cable_type1'])
    assert_equal('ready for a NIM operation', stanza.data['curso01']['Cstate'])
    assert_equal('ready for a NIM operation', stanza.data['curso01']['prev_state'])
    assert_equal('currently running',         stanza.data['curso01']['Mstate'])
    assert_equal('00F690DC4C00',              stanza.data['curso01']['cpuid'])

    assert_equal(7,                     stanza.data['acceptance_setup_fb_script'].count)
    assert_equal('resources',           stanza.data['acceptance_setup_fb_script']['class'])
    assert_equal('fb_script',           stanza.data['acceptance_setup_fb_script']['type'])
    assert_equal('ready for use',       stanza.data['acceptance_setup_fb_script']['Rstate'])
    assert_equal('unavailable for use', stanza.data['acceptance_setup_fb_script']['prev_state'])
    assert_equal('/export/nim/fb_script/acceptance_setup.sh',                  stanza.data['acceptance_setup_fb_script']['location'])
    assert_equal(2,                     stanza.data['acceptance_setup_fb_script']['alloc_count'])
    assert_equal('master',              stanza.data['acceptance_setup_fb_script']['server'])

  end
end
