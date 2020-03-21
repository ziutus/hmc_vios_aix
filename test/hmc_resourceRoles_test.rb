$LOAD_PATH << File.dirname(__FILE__) + '/../lib'
$LOAD_PATH << File.dirname(__FILE__) + './lib'

require 'HMC/ResourceRole'
require 'HMC/ResourceRoles'
require 'test/unit'

class TestHMCResourceRoles < Test::Unit::TestCase

  
  def test_constructor
    string = 'name=L2support,"resources=lpar:root/ibmhscS1_0|ALL_PARTITIONS*9131-52A*6535CCG|IBMHSC_Partition"
name=LparAdmin,"resources=lpar:root/ibmhscS1_0|1*9131-52A*6535CCG|IBMHSC_Partition,lpar:root/ibmhscS1_0|5*9131-52A*6535CCG|IBMHSC_Partition"'

    roles = ResourceRoles.new(string)

    assert_equal(false, roles.role_exist?('L3support'))
    assert_equal(true,  roles.role_exist?('L2support'))
    assert_equal(true , roles.role_exist?('LparAdmin'))


    assert_equal(true,  roles.has_lpar?('LparAdmin',    '9131-52A*6535CCG', '1'))
    assert_equal(false, roles.has_lpar?('LparAdmin',    '9131-52A*6535CCG', '2'))
    assert_equal(false, roles.has_lpar?('NotexistRole', '9131-52A*6535CCG', '2'))
    assert_equal(false, roles.has_lpar?('L2support',    '9131-52A*0000000', '2'))
    assert_equal(true,  roles.has_lpar?('L2support',    '9131-52A*6535CCG', '4'))

    assert_equal(true,   roles.has_lpar?('LparAdmin,LparAdmin2',     '9131-52A*6535CCG', '1'))
    assert_equal(false,  roles.has_lpar?('LparAdmin2,LparAdmin3',    '9131-52A*6535CCG', '1'))

  end

  def test_lpar_has_roles

    string = 'name=L2support,"resources=lpar:root/ibmhscS1_0|ALL_PARTITIONS*9131-52A*6535CCG|IBMHSC_Partition"
name=LparAdmin,"resources=lpar:root/ibmhscS1_0|1*9131-52A*6535CCG|IBMHSC_Partition,lpar:root/ibmhscS1_0|5*9131-52A*6535CCG|IBMHSC_Partition"'

    roles = ResourceRoles.new(string)

    result = roles.lpar_has_roles('9131-52A*6535CCG', 5)
    assert_equal('L2support', result[0])
    assert_equal('LparAdmin', result[1])
    assert_equal(2, result.count)

  end

  def test_lpar_has_all_partitions

    string = 'name=L2support,"resources=lpar:root/ibmhscS1_0|ALL_PARTITIONS*9131-52A*6535CCG|IBMHSC_Partition"
name=LparAdmin,"resources=lpar:root/ibmhscS1_0|1*9131-52A*6535CCG|IBMHSC_Partition,lpar:root/ibmhscS1_0|5*9131-52A*6535CCG|IBMHSC_Partition"'

    roles = ResourceRoles.new(string)

    result = roles.roles_has_all_partitions('9131-52A*6535CCG')
    assert_equal('L2support', result[0])
    assert_equal(1, result.count)

  end


  def test_delete

    string = 'name=L2support,"resources=lpar:root/ibmhscS1_0|ALL_PARTITIONS*9131-52A*6535CCG|IBMHSC_Partition"
name=LparAdmin,"resources=lpar:root/ibmhscS1_0|1*9131-52A*6535CCG|IBMHSC_Partition,lpar:root/ibmhscS1_0|5*9131-52A*6535CCG|IBMHSC_Partition"'

    roles = ResourceRoles.new(string)

    assert_equal(false, roles.role_exist?('L3support'))
    assert_equal(true,  roles.role_exist?('L2support'))
    assert_equal(true , roles.role_exist?('LparAdmin'))

    result = roles.lpar_has_roles('9131-52A*6535CCG', 5)
    assert_equal('L2support', result[0])
    assert_equal('LparAdmin', result[1])
    assert_equal(2, result.count)


    roles.role_delete('L2support')

    assert_equal(false, roles.role_exist?('L3support'))
    assert_equal(false, roles.role_exist?('L2support'))
    assert_equal(true , roles.role_exist?('LparAdmin'))

  end

  def test_list_cmd
    assert_equal('lsaccfg  -t resourcerole', ResourceRoles.new.role_list_cmd)
  end

  def test_create_cmd
    assert_equal('mkaccfg -t resourcerole -i "name=TestTest,resources="',  ResourceRoles.new.role_create_cmd('TestTest'))
  end

  def test_delete_cmd
    assert_equal('rmaccfg -t resourcerole -n TestTest', ResourceRoles.new.role_delete_cmd('TestTest'))
  end

  def test_access_add_remove_cmd

    roles = ResourceRoles.new()
    assert_equal('chaccft -t resourcerole -i "name=TestRole,resources+=lpar:root/ibmhsc01_0|1*1*9131-52A*6535CCG|IBMHSC_Partition"', roles.lpar_add_to_role_cmd(   'TestRole', '1*9131-52A*6535CCG',1 ))
    assert_equal('chaccft -t resourcerole -i "name=TestRole,resources-=lpar:root/ibmhsc01_0|1*1*9131-52A*6535CCG|IBMHSC_Partition"', roles.lpar_remove_from_role_cmd(   'TestRole', '1*9131-52A*6535CCG',1 ))

  end

end			
