$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'AIX/ErrptEntry'
require 'test/unit'
require 'pp'

# noinspection RubyResolve
class TestAixErrptEntry < Test::Unit::TestCase

#9DBCFDEE   0929104613 T O errdemon       ERROR LOGGING TURNED ON
#192AC071   0926092513 T O errdemon       ERROR LOGGING TURNED OFF
#A6DF45AA   0925162713 I O RMCdaemon      The daemon is started.
#1BA7DF4E   0925162713 P S SRC            SOFTWARE PROGRAM ERROR

  # example data taken from: http://www.unixmantra.com/2013/09/aix-os-errpt-error-output-explained.html
	def test_decode_1
        string='982C78BF   0930152713 T S mir0           DISPLAY ADAPTER CONFIGURATION ERROR'

        entry = ErrptEntry.new(string)
        assert_equal('982C78BF',    entry.identifier)
        assert_equal('0930152713',  entry.datetime)
        assert_equal('T', 			entry.type)
        assert_equal('S', 			entry.class)
        assert_equal('mir0', 		entry.resource_name)
        assert_equal('DISPLAY ADAPTER CONFIGURATION ERROR', entry.description)
    end

  # example data taken from: http://www.unixmantra.com/2013/09/aix-os-errpt-error-output-explained.html
  def test_decode_2
    string='49A83216   0930152913 T H hdisk0         DISK OPERATION ERROR'

    entry = ErrptEntry.new(string)
    assert_equal('49A83216',    entry.identifier)
    assert_equal('0930152913',  entry.datetime)
    assert_equal('T', 			entry.type)
    assert_equal('H', 			entry.class)
    assert_equal('hdisk0', 		entry.resource_name)
    assert_equal('DISK OPERATION ERROR', entry.description)
  end

  # example data taken from: http://www.unixmantra.com/2013/09/aix-os-errpt-error-output-explained.html
  def test_decode_3
    string='9DBCFDEE   0929104613 T O errdemon       ERROR LOGGING TURNED ON'

    entry = ErrptEntry.new(string)
    assert_equal('9DBCFDEE',    entry.identifier)
    assert_equal('0929104613',  entry.datetime)
    assert_equal('T', 			entry.type)
    assert_equal('O', 			entry.class)
    assert_equal('errdemon', 		entry.resource_name)
    assert_equal('ERROR LOGGING TURNED ON', entry.description)
  end

  # example data taken from: http://www.unixmantra.com/2013/09/aix-os-errpt-error-output-explained.html
  def test_decode_long_1

    string='LABEL:          DISK_ERR4
IDENTIFIER:     49A83216

Date/Time:       Thu Sep 30 15:29:45 CST 2013
Sequence Number: 25
Machine Id:      000788574C00
Node Id:         localhost
Class:           H
Type:            TEMP
Resource Name:   hdisk0          
Resource Class:  disk
Resource Type:   scsd
Location:        P1/Z1-A0
VPD:             
        Manufacturer................IBM     
        Machine Type and Model......ST318305LW      
        FRU Number..................09P4429     
        ROS Level and ID............43353042
        Serial Number...............000A2D99
        EC Level....................H11936    
        Part Number.................09P4428     
        Device Specific.(Z0)........000003129F00013E
        Device Specific.(Z1)........0501C50B
        Device Specific.(Z2)........1000
        Device Specific.(Z3)........02121
        Device Specific.(Z4)........0001
        Device Specific.(Z5)........22
        Device Specific.(Z6)........162870 C  

Description
DISK OPERATION ERROR

Probable Causes
MEDIA
DASD DEVICE

User Causes
MEDIA DEFECTIVE

        Recommended Actions
        FOR REMOVABLE MEDIA, CHANGE MEDIA AND RETRY
        PERFORM PROBLEM DETERMINATION PROCEDURES

Failure Causes
MEDIA
DISK DRIVE

        Recommended Actions
        FOR REMOVABLE MEDIA, CHANGE MEDIA AND RETRY
        PERFORM PROBLEM DETERMINATION PROCEDURES

Detail Data
PATH ID
           0
SENSE DATA
0A00 0000 2800 00DB 67B0 0000 1800 0000 0200 0400 0000 0000 0000 0000 0000 0000 
0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 
0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 
0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 
0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 001A 0000'

    entry = ErrptEntry.new(string)
    assert_equal('DISK_ERR4', entry.label)
    assert_equal('49A83216', entry.identifier)
    assert_equal('Thu Sep 30 15:29:45 CST 2013', entry.datetime_long)
#		assert_equal('hdisk0', entry.resource_name)
  end
end
