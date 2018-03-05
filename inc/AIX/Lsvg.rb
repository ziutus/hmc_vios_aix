require 'pp'

class Lsvg

  attr_reader :volume_group
  attr_reader :vg_state
  attr_reader :vg_identifier
  attr_reader :vg_state
  attr_reader :pp_size
  attr_reader :vg_permission
  attr_reader :total_pps
  attr_reader :max_lvs
  attr_reader :free_pps
  attr_reader :used_pps
  attr_reader :lvs
  attr_reader :open_lvs
  attr_reader :quorum
  attr_reader :total_pvs
  attr_reader :vg_descriptors
  attr_reader :active_pvs
  attr_reader :stale_pvs
  attr_reader :stale_pps
  attr_reader :auto_on
  attr_reader :max_pps_per_vg
  attr_reader :max_pps_per_pv
  attr_reader :max_pvs
  attr_reader :ltg_size_dynamic
  attr_reader :auto_sync
  attr_reader :hot_spare
  attr_reader :bb_policy

  def initialize(string)

    @data_string_raw=''


    @volume_group = nil
    @vg_state = nil
    @vg_identifier = nil
    @vg_state = nil
    @pp_size = nil
    @vg_permission = nil
    @total_pps = nil
    @max_lvs = nil
    @free_pps = nil
    @used_pps = nil
    @lvs = nil
    @open_lvs = nil
    @quorum = nil
    @total_pvs = nil
    @vg_descriptors = nil
    @active_pvs = nil
    @stale_pvs = nil
    @stale_pps = nil
    @auto_on = nil
    @max_pps_per_vg = nil
    @max_pps_per_pv = nil
    @max_pvs = nil
    @ltg_size_dynamic = nil
    @auto_sync = nil
    @hot_spare = nil
    @bb_policy = nil

    if string.length > 0
      @data_string_raw = string
      self.parse(string)
    end
  end


  def parse(string)

    regexp_long = %r{\s*
VOLUME\sGROUP:\s+(\w+)\s+VG\sIDENTIFIER:\s+(\w+)\s+
VG\sSTATE:\s+(active)\s+PP\sSIZE:\s+(\d+\smegabyte\(s\))\s+
VG\sPERMISSION:\s+(read\/write)\s+TOTAL\sPPs:\s+(\d+)\s\(\d+\smegabytes\)\s+
MAX\sLVs:\s+(\d+)\s+FREE\sPPs:\s+(\d+)\s\(\d+\smegabytes\)\s+
LVs:\s+(\d+)\s+USED\sPPs:\s+(\d+)\s\(\d+\smegabytes\)\s+
OPEN\sLVs:\s+(\d+)\s+QUORUM:\s+(\d+)\s+
TOTAL\sPVs:\s+(\d+)\s+VG\s+DESCRIPTORS:\s+(\d+)\s+
STALE\sPVs:\s+(\d+)\s+STALE\sPPs:\s+(\d+)\s+
ACTIVE\sPVs:\s+(\d+)\s+AUTO\sON:\s+(yes|no)\s+
MAX\sPPs\sper\sVG:\s+(\d+)\s+
MAX\sPPs\sper\sPV:\s+(\d+)\s+MAX\s+PVs:\s+(\d+)\s+
LTG\ssize\s\(Dynamic\):\s+(\d+\skilobyte\(s\))\s+AUTO\sSYNC:\s+(yes|no)\s+
HOT\sSPARE:\s+(yes|no)\s+BB\sPOLICY:\s+(relocatable)\s*}mx

    match_long = regexp_long.match(string)

if match_long

      @volume_group = match_long[1]
      @vg_identifier = match_long[2]
      @vg_state 			= match_long[3]
      @pp_size  			= match_long[4]
      @vg_permission  = match_long[5]
      @total_pps      = match_long[6].to_i
      @max_lvs        = match_long[7].to_i
      @free_pps       = match_long[8].to_i
      @lvs       = match_long[9].to_i
      @used_pps       = match_long[10].to_i
      @open_lvs       = match_long[11].to_i
      @quorum       = match_long[12].to_i
      @total_pvs       = match_long[13].to_i
      @vg_descriptors = match_long[14].to_i
      @stale_pvs        = match_long[15].to_i
      @stale_pps        = match_long[16].to_i
      @active_pvs       = match_long[17].to_i
      @auto_on       = match_long[18]
      @max_pps_per_vg  = match_long[19].to_i
      @max_pps_per_pv = match_long[20].to_i
      @max_pvs = match_long[21].to_i
      @ltg_size_dynamic = match_long[22]
      @auto_sync = match_long[23]
      @hot_spare = match_long[24]
      @bb_policy = match_long[25]

else
      #puts "can't analyze string, regexp is not working"
      #puts string
      #puts regexp
      #puts match
      puts "regexp couldn't decode string >#{string}<"
      raise
    end

  end

end