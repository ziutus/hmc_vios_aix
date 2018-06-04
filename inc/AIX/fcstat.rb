class Fcstat

  attr_accessor :data_string_raw
  attr_accessor :device
  attr_accessor :data

  attr_reader :_parsed

  def initialize(string)
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

    regexp = %r{FIBRE\sCHANNEL\sSTATISTICS\sREPORT:\s(fcs\d+)\s+
Device\sType:\s(.*?)\s+
Serial\sNumber:\s(\w+)\s+
Option\sROM\sVersion:\s(\w+)\s+
ZA:\s([\w\.]+)\s+
Node\sWWN:\s(\w+)\s+
Port\sWWN:\s(\w+)\s+
\s+
FC4\sTypes\s+
\s+Supported:\s+(0x\d+)\s+
\s+Active:\s+(0x\d+)\s+
Class\sof\sService:\s+(\d+)\s+
Port\sFC\sID:\s+(\w+)\s+
Port\sSpeed\s\(supported\):\s+(\d+\sGBIT)\s+
Port\sSpeed\s\(running\):\s+(\d+\sGBIT)\s+
Port\sType:\s(Fabric)\s+
\s+
Seconds\sSince\sLast\sReset:\s+(\d+)\s+
\s+
Transmit\sStatistics\s+Receive\sStatistics\s+
[-]+\s+[-]+\s+
Frames:\s(\d+)\s+Frames:\s(\d+)\s+
Words:\s(\d+)\s+Words:\s(\d+)\s+
\s+
LIP\sCount:\s+(\d+)\s+
NOS\sCount:\s+(\d+)\s+
Error\sFrames:\s+(\d+)\s+
Dumped\sFrames:\s+(\d+)\s+
Link\sFailure\sCount:\s+(\d+)\s+
Loss\sof\sSync\sCount:\s+(\d+)\s+
Loss\sof\sSignal:\s+(\d+)\s+
Primitive\sSeq\sProtocol\sErr\sCount:\s+(\d+)\s+
Invalid\sTx\sWord\sCount:\s+(\d+)\s+
Invalid\sCRC\sCount:\s+(\d+)\s+
\s+
\s+
IP\sover\sFC\sAdapter\sDriver\sInformation\s+
\s+No\sDMA\sResource\sCount:\s+(\d+)\s+
\s+No\sAdapter\sElements\sCount:\s+(\d+)\s+
\s+
FC\sSCSI\sAdapter\sDriver\sInformation\s+
\s+No\sDMA\sResource\sCount:\s+(\d+)\s+
\s+No\sAdapter\sElements\sCount:\s+(\d+)\s+
\s+No\sCommand\sResource\sCount:\s+(\d+)\s+
\s+
IP\sover\sFC\sTraffic\sStatistics\s+
\s+Input\sRequests:\s+(\d+)\s+
\s+Output\sRequests:\s+(\d+)\s+
\s+Control\sRequests:\s+(\d+)\s+
\s+Input\sBytes:\s+(\d+)\s+
\s+Output\sBytes:\s+(\d+)\s+
\s+
FC\sSCSI\sTraffic\sStatistics\s+
\s+Input\sRequests:\s+(\d+)\s+
\s+Output\sRequests:\s+(\d+)\s+
\s+Control\sRequests:\s+(\d+)\s+
\s+Input\sBytes:\s+(\d+)\s+
\s+Output\sBytes:\s+(\d+)\s*
}x

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
      @data['ZA']                 = match[5]
      @data['Node WWN']           = match[6]
      @data['Port WWN']           = match[7]
      @data['FC4 Types'] = { 'Supported' => match[8], 'Active' => match[9]  }

      @data['Class of Service']       = match[10]
      @data['Port FC ID']             = match[11]
      @data['Port Speed (supported)'] = match[12]
      @data['Port Speed (running)']   = match[13]
      @data['Port Type']              = match[14]
      @data['Seconds Since Last Reset'] = match[15].to_i
      @data['Transmit Statistics'] = { 'Frames' => match[16].to_i, 'Words'  => match[18].to_i}
      @data['Receive Statistics'] = { 'Frames' => match[17].to_i, 'Words'  => match[19].to_i}
      @data['LIP Count']          = match[20].to_i
      @data['NOS Count']          = match[21].to_i
      @data['Error Frames']       = match[22].to_i
      @data['Dumped Frames']      = match[23].to_i
      @data['Link Failure Count'] = match[24].to_i
      @data['Loss of Sync Count'] = match[25].to_i
      @data['Loss of Signal']     = match[26].to_i
      @data['Primitive Seq Protocol Err Count'] = match[27].to_i
      @data['Invalid Tx Word Count'] = match[28].to_i
      @data['Invalid CRC Count']     = match[29].to_i
      @data['IP over FC Adapter Driver Information'] = { 'No DMA Resource Count'=> match[30].to_i,  'No Adapter Elements Count' => match[31].to_i  }

      @data['FC SCSI Adapter Driver Information'] = { 'No DMA Resource Count' => match[32].to_i, 'No Adapter Elements Count' => match[33].to_i, 'No Command Resource Count' => match[34].to_i }

      @data['IP over FC Traffic Statistics']= { 'Input Requests'  => match[35].to_i, 'Output Requests' => match[36].to_i,  'Control Requests' => match[37].to_i, 'Input Bytes' => match[38].to_i,  'Output Bytes' => match[39].to_i  }
      @data['FC SCSI Traffic Statistics'] =   { 'Input Requests'  => match[40].to_i, 'Output Requests' => match[41].to_i,'Control Requests' => match[42].to_i, 'Input Bytes' => match[43].to_i,  'Output Bytes' => match[44].to_i  }

    else
      puts "can't analyze string, regexp is not working"
      puts string
      raise 'fcstat - regexp is not working'
    end

    @_parsed = true
  end

end