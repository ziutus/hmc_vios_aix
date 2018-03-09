require 'pp'

class Lsvg_p

  attr_reader :volume_group
  attr_reader :disks

  attr_reader :missing
  attr_reader :active

  def initialize(string)

    @data_string_raw=''
    @disks = Hash.new

    @volume_group = nil

    @active  = Array.new
    @missing = Array.new

    if string.length > 0
      self.parse(string)
      @data_string_raw = string
    end
  end


  def parse(string)

   string.split("\n").each { |line|

#     pp line

     match_vg    = %r{^([\w\_]+):\s*$}.match(line)
     match_hdisk = %r{([\w\d]+)\s+(active|missing)\s+(\d+)\s+(\d+)\s+([\d\.]+)}.match(line)

     if line =~ /^\s*$/
       next
     elsif match_vg
        @volume_group = match_vg[1]
     elsif line =~ %r{PV_NAME\s+PV\sSTATE\s+TOTAL\sPPs\s+FREE\sPPs\s+FREE\sDISTRIBUTION}
       next
     elsif match_hdisk
       disk = Hash.new
       disk['pv_name']           = match_hdisk[1]
       disk['pv_state']          = match_hdisk[2]
       disk['total_pps']         = match_hdisk[3].to_i
       disk['free_pps']          = match_hdisk[4].to_i
       disk['free_distribution'] = match_hdisk[5]

       if disk['pv_state'] == 'active'
          @active.push(disk['pv_name'])
       elsif disk['pv_state'] == 'missing'
         @missing.push(disk['pv_name'])

       else
         pp line
         raise 'wrong pv state'
       end

       @disks[disk['pv_name']] = disk
     else
            pp "Wrong line:>#{line}<"
     end


   }


  end


end