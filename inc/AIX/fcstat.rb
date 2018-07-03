class Fcstat

  attr_accessor :data_string_raw
  attr_accessor :device
  attr_accessor :data

  attr_reader :_parsed

  def initialize(string = '')
    @data = {}
    @data_string_raw = ''
    @_parsed = false

    parse(string) unless string.empty?
  end

  def stats
    @data
  end

  alias get_stats stats

  def parse(string)
    @data_string_raw = string

    # information about topology taken from:
    # http://ibmsystemsmag.com/aix/administrator/systemsmanagement/tips-from-techu/

    regexp = %r{FIBRE\sCHANNEL\sSTATISTICS\sREPORT:\s(fcs\d+)\s+
Device\sType:\s(.*?)\s+
Serial\sNumber:\s(\w+)\s+
Option\sROM\sVersion:\s(\w+)\s+
(ZA:\s[\w\.]+|)\s*
(Firmware\sVersion:\s[\w\.]+|)\s*
(?:Node\sWWN|World\sWide\sNode\sName):\s(\w+)\s+
(?:Port\sWWN|World\sWide\sPort\sName):\s(\w+)\s+
\s+
FC(?:-|)4\s(?:TYPES:|Types)\s+
\s+Supported:\s+(0x\d+)\s+
\s+Active:\s+(0x\d+)\s+
Class\sof\sService:\s+(\d+)\s+
(Port\sFC\sID:\s+\w+|)\s*
Port\sSpeed\s\(supported\):\s+(\d+\sGBIT|UNKNOWN)\s+
Port\sSpeed\s\(running\):\s+(\d+\sGBIT|UNKNOWN)\s+
(Port\sFC\sID:\s+\w+|)\s*
Port\sType:\s(Fabric)\s+
(Attention\sType:\s+Link\sUp|Attention\sType:\s+Link\sDown|Attention\sType:\s+UNKNOWN|)\s*
(Topology:\s+Point\sto\sPoint\sor\sFabric|Topology:\s+UNKNOWN|)\s*
\s+
Seconds\sSince\sLast\sReset:\s+(\d+)\s+
\s+
Transmit\sStatistics\s+Receive\sStatistics\s+
[-]+\s+[-]+\s+
Frames:\s+([-\d]+)\s*(?:Frames:\s|)([-\d]+)\s+
Words:\s+([-\d]+)\s*(?:Words:\s|)([-\d]+)\s+
\s+
LIP\sCount:\s+([-\d]+)\s+
NOS\sCount:\s+([-\d]+)\s+
Error\sFrames:\s+([-\d]+)\s+
Dumped\sFrames:\s+([-\d]+)\s+
Link\sFailure\sCount:\s+([-\d]+)\s+
Loss\sof\sSync\sCount:\s+([-\d]+)\s+
Loss\sof\sSignal:\s+([-\d]+)\s+
Primitive\sSeq\sProtocol\s(?:Err|Error)\sCount:\s+([-\d]+)\s+
Invalid\sTx\sWord\sCount:\s+([-\d]+)\s+
Invalid\sCRC\sCount:\s+([-\d]+)\s+
\s+
(IP\sover\sFC\sAdapter\sDriver\sInformation\s+.*)
(FC\sSCSI\sAdapter\sDriver\sInformation\s+.*)
(IP\sover\sFC\sTraffic\sStatistics\s+.*)
(FC\sSCSI\sTraffic\sStatistics\s+.*)$}mx


    if string =~ /^\s*Error\saccessing\sODM\s*Device\snot\sfound\s*$/
      raise 'Error accessing ODM - Device not found'
    elsif string =~ /^\s*Error\saccessing\sODM\s*VPD\sinformation\snot\sfound\s*$/
      raise 'Error accessing ODM - VPD information not found'
    elsif match = regexp.match(string)
      @device = match[1]

      @data['device']             = match[1]
      @data['Device Type']        = match[2]
      @data['Serial Number']      = match[3]
      @data['Option ROM Version'] = match[4]
      @data['ZA']                 = match[5].sub('ZA: ', '') unless match[5].empty?
      @data['Firmware version']   = match[6].sub('Firmware Version: ', '') unless match[6].empty?
      @data['Node WWN']           = match[7]
      @data['Port WWN']           = match[8]
      @data['FC4 Types'] = { 'Supported' => match[9], 'Active' => match[10] }

      @data['Class of Service']       = match[11]
      @data['Port FC ID']             = match[12].gsub('Port FC ID: ', '') unless match[12].nil? || match[12].empty?
      @data['Port Speed (supported)'] = match[13]
      @data['Port Speed (running)']   = match[14]
      @data['Port FC ID']             = match[15].gsub('Port FC ID: ', '') unless match[15].nil? || match[15].empty?
      @data['Port Type']              = match[16]
      @data['Attention Type']         = match[17].gsub('Attention Type:', '').strip unless match[17].nil? || match[17].empty?
      @data['Topology']               = match[18].gsub('Topology:', '').strip unless match[18].nil? || match[18].empty?
      @data['Seconds Since Last Reset'] = match[19].to_i
      @data['Transmit Statistics'] = { 'Frames' => match[20].to_i, 'Words'  => match[22].to_i}
      @data['Receive Statistics'] = { 'Frames' => match[21].to_i, 'Words'  => match[23].to_i}
      @data['LIP Count']          = match[24].to_i
      @data['NOS Count']          = match[25].to_i
      @data['Error Frames']       = match[26].to_i
      @data['Dumped Frames']      = match[27].to_i
      @data['Link Failure Count'] = match[28].to_i
      @data['Loss of Sync Count'] = match[29].to_i
      @data['Loss of Signal']     = match[30].to_i
      @data['Primitive Seq Protocol Err Count'] = match[31].to_i
      @data['Invalid Tx Word Count'] = match[32].to_i
      @data['Invalid CRC Count']     = match[33].to_i
      @data['IP over FC Adapter Driver Information'] = parse_ip_over_fc_adapter_driver_information(match[34]) unless match[34].nil? or match[34].empty?
      @data['FC SCSI Adapter Driver Information'] = parse_fc_scsi_adapter_driver_information(match[35]) unless match[35].nil? or match[35].empty?
      @data['IP over FC Traffic Statistics'] = parse_ip_over_fc_traffic_statistics(match[36])  unless match[36].nil? or match[36].empty?
      @data['FC SCSI Traffic Statistics'] = parse_fc_scsi_traffic_statistics(match[37])  unless match[37].nil? or match[37].empty?

    else
      raise Exception, "fcstat - regexp is not working for string >#{string}<"
    end

    @_parsed = true
  end

  def parse_fc_scsi_traffic_statistics(string)
    result = {}
    regexp = %r{FC\sSCSI\sTraffic\sStatistics\s+
\s+Input\sRequests:\s+(\d+)\s+
\s+Output\sRequests:\s+(\d+)\s+
\s+Control\sRequests:\s+(\d+)\s+
\s+Input\sBytes:\s+(\d+)\s+
\s+Output\sBytes:\s+(\d+)\s*
}x
    if match = regexp.match(string)
      return { 'Input Requests' => match[1].to_i, 'Output Requests' => match[2].to_i,'Control Requests' => match[3].to_i, 'Input Bytes' => match[4].to_i,
               'Output Bytes' => match[5].to_i }
    else
      raise Exception, "can't parse string >#{string}"
    end


  end

  def parse_ip_over_fc_traffic_statistics(string)
    regexp = %r{^\s*IP\sover\sFC\sTraffic\sStatistics\s+
\s+Input\sRequests:\s+(\d+)\s+
\s+Output\sRequests:\s+(\d+)\s+
\s+Control\sRequests:\s+(\d+)\s+
\s+Input\sBytes:\s+(\d+)\s+
\s+Output\sBytes:\s+(\d+)\s*$}x

    if match = regexp.match(string)
      return { 'Input Requests' => match[1].to_i, 'Output Requests' => match[2].to_i, 'Control Requests' => match[3].to_i,
               'Input Bytes' => match[4].to_i, 'Output Bytes' => match[5].to_i }
    else
      raise Exception, "Can't parse string >#{string}<"
    end
  end

  def parse_fc_scsi_adapter_driver_information(string)
    regexp = %r{^\s*FC\sSCSI\sAdapter\sDriver\sInformation\s+
\s+No\sDMA\sResource\sCount:\s+(\d+)\s+
\s+No\sAdapter\sElements\sCount:\s+(\d+)\s+
\s+No\sCommand\sResource\sCount:\s+(\d+)\s*$}x

    if match = regexp.match(string)
      return { 'No DMA Resource Count' => match[1].to_i, 'No Adapter Elements Count' => match[2].to_i, 'No Command Resource Count' => match[3].to_i }
    else
      raise Exception, "Can't parse string >#{string}<"
    end
  end

  def parse_ip_over_fc_adapter_driver_information(string)
    regexp = %r{^\s*IP\sover\sFC\sAdapter\sDriver\sInformation\s+
\s+No\sDMA\sResource\sCount:\s+(\d+)\s+
\s+No\sAdapter\sElements\sCount:\s+(\d+)\s+
\s+No\sCommand\sResource\sCount:\s+(\d+)\s*$}x

    regexp2 = %r{^\s*IP\sover\sFC\sAdapter\sDriver\sInformation\s+
\s+No\sDMA\sResource\sCount:\s+(\d+)\s+
\s+No\sAdapter\sElements\sCount:\s+(\d+)\s*$}x

    if match = regexp.match(string)
      return {
        'No DMA Resource Count' => match[1].to_i,
        'No Adapter Elements Count' => match[2].to_i,
        'No Command Resource Count' => match[3].to_i
      }
    elsif match2 = regexp2.match(string)
      return {
        'No DMA Resource Count' => match2[1].to_i,
        'No Adapter Elements Count' => match2[2].to_i,
      }
    else
      raise Exception, "Can't parse string >#{string}<"
    end
  end
end