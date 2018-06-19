require 'Framework/hmcDir'

class HmcData

  attr_accessor :directory
  attr_accessor :date
  attr_accessor :verbose

  def initialize(directory, date, verbose = 0)
    @directory = directory
    @date = date
    @verbose = verbose
  end

  def frames_with_lpar(lpar_to_find)
    systems_found = []
    Dir.chdir(@directory + '/' + @date + '/')
    Dir.glob('*').select do |hmc|
      puts ">DEBUG: Checking HMC #{hmc} " if @verbose > 0
      next unless File.directory? hmc

      hmc_data = HmcDir.new(directory + '/' + date + '/' + hmc)
      hmc_data.verbose = verbose

      hmc_data.create_list_of_frames

      hmc_data.sys.each do |sys_name|
        sys = System.new(sys_name)
        sys.parse_raw_data(hmc_data.file_content(sys_name, 'lpar_info'))
        systems_found.push("#{sys.name}:#{hmc}") if sys.lpars_by_name.include?(lpar_to_find)
      end
    end

    systems_found
  end
end