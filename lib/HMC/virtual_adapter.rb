class VirtualAdapter

  attr_accessor :virtualSlotNumber
  attr_accessor :isRequired

  # below data can be taken only from lshwres, they are exist only for running lpars
  attr_accessor :lpar_name
  attr_accessor :lpar_id
  attr_accessor :state

  # type of input / output (data can be taken from profile or real setup (lshwres...))
  attr_reader :_type

  # for compare where important are only adapters
  attr_accessor :vios
  attr_accessor :frame


  def initialize(string = '')
    @lpar_name = nil
    @lpar_id = nil
    @state = nil
    @isRequired = 0
    @_type = 'profile'

    @vios = nil
    @frame = nil

    @params = []
  end

  def diff(other_adapter, profile1, profile2, null_0_none_equal = false )
    diff = {}

    if self.class.name != other_adapter.class.name
      raise "Wrong type of adapter has been compared #{other_adapter.class.name}"
    end

    @params.sort.each do |param|
      next if  instance_variable_get("@#{param}") == other_adapter.instance_variable_get("@#{param}")

      if null_0_none_equal
        a = instance_variable_get("@#{param}")
        b = other_adapter.instance_variable_get("@#{param}")
        next if ( a.to_s == '0' || a == 'none' || a == 'null')  && (b.to_s == '0' || b == 'none' || b == 'null')
      end

      diff_entry = {}
      diff_entry[profile2] = other_adapter.instance_variable_get("@#{param}")
      diff_entry[profile1]  = instance_variable_get("@#{param}")
      diff[param.to_s] = diff_entry
    end

    diff
  end

  def ==(other)
    to_s == other.to_s
  end

end