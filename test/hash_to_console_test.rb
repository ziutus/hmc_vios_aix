$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__)+'./lib'

require 'test/unit'
require 'pp'
require 'hash_to_consol'

class HashToConsoleTest2 < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test1

    hash1 = {'id'=>'1228945898091',
             'amount'=>'0.06037590',
             'balance_after'=>'0.06037590',
             'currency'=>'btc',
             'operation_type'=>'+currency_transaction',
             'time'=>'2017-11-08 18:47:40',
             'comment'=>''}

    hash2 = {'id'=>'12887368055349',
             'amount'=>'-0.05935607',
             'balance_after'=>'0',
             'currency'=>'btc',
             'operation_type'=>'-pay_for_currency',
             'time'=>'2017-11-05 21:38:57',
             'comment'=>''}

    array = [  hash1, hash2 ]

    #pp array

    console = HashToConsole.new
    console.add_hash(array)

    assert_equal('12887368055349;-0.05935607;            0;     btc;    -pay_for_currency;2017-11-05 21:38:57;       ;', console.to_s.split("\n")[2])

    console.col_disable(1)
    assert_equal('-0.05935607;            0;     btc;    -pay_for_currency;2017-11-05 21:38:57;       ;', console.to_s.split("\n")[2])

    console.col_enable(1)
    assert_equal('12887368055349;-0.05935607;            0;     btc;    -pay_for_currency;2017-11-05 21:38:57;       ;', console.to_s.split("\n")[2])

    console.col_disable('id')
    assert_equal('-0.05935607;            0;     btc;    -pay_for_currency;2017-11-05 21:38:57;       ;', console.to_s.split("\n")[2])

    console.col_enable('id')
    assert_equal('12887368055349;-0.05935607;            0;     btc;    -pay_for_currency;2017-11-05 21:38:57;       ;', console.to_s.split("\n")[2])

    console.col_disable('id,comment')
    assert_equal('-0.05935607;            0;     btc;    -pay_for_currency;2017-11-05 21:38:57;', console.to_s.split("\n")[2])

    console.col_enable('id,comment')
    assert_equal('12887368055349;-0.05935607;            0;     btc;    -pay_for_currency;2017-11-05 21:38:57;       ;', console.to_s.split("\n")[2])

  end

  def test2
    hash1 = {'id'=>'1228945898091',
             'amount'=>'0.06037590',
             'balance_after'=>'0.06037590',
             'currency'=>'btc',
             'operation_type'=>'+currency_transaction',
             'time'=>'2017-11-08 18:47:40',
             'comment'=>''}

    hash2 = {'id'=>'12887368055349',
             'amount'=>'-0.05935607',
             'balance_after'=>'0',
             'currency'=>'btc',
             'operation_type'=>'-pay_for_currency',
             'time'=>'2017-11-05 21:38:57',
             'comment'=>''}

    array = [  hash1, hash2 ]

    console = HashToConsole.new
    console.add_hash(array)


    assert_equal(0, console.get_col_id('id'))
    assert_equal(1, console.get_col_id('amount'))
    assert_equal(2, console.get_col_id('balance_after'))
    assert_equal(3, console.get_col_id('currency'))
    assert_equal(4, console.get_col_id('operation_type'))
    assert_equal(5, console.get_col_id('time'))
    assert_equal(6, console.get_col_id('comment'))

    assert_equal(14, console.get_col_size('id'))
    assert_equal(19, console.get_col_size('time'))
    assert_equal(7, console.get_col_size('comment'))

    assert_equal('1228945898091', console.get_value(1,'id'))
    assert_equal(' 1228945898091', console.get_value_nice(1,'id'))


#    assert_equal('12887368055349', console.get_value(2,1))
#    assert_equal('12887368055349', console.get_value(2,'id'))

    output =  console.to_s_F('time;currency;amount')

#pp output
    assert_equal('               time;currency;     amount;', output.split("\n")[0])
    assert_equal('2017-11-08 18:47:40;     btc; 0.06037590;', output.split("\n")[2])

  end

  def test3
    hash1 = {'id'=>'1228945898091',
             'amount'=>'0.06037590',
             'balance_after'=>'0.06037590',
             'currency'=>'btc',
             'operation_type'=>'+currency_transaction',
             'time'=>'2017-11-08 18:47:40',
             'comment'=>''}

    array = [  hash1 ]

    console = HashToConsole.new
    console.add_hash(array)

    assert_equal(0, console.get_col_id('id'))
    assert_equal(1, console.get_col_id('amount'))
    assert_equal(2, console.get_col_id('balance_after'))
    assert_equal(3, console.get_col_id('currency'))
    assert_equal(4, console.get_col_id('operation_type'))
    assert_equal(5, console.get_col_id('time'))
    assert_equal(6, console.get_col_id('comment'))

    assert_equal(13, console.get_col_size('id'))
    assert_equal(10, console.get_col_size('amount'))
    assert_equal(13, console.get_col_size('balance_after'))
    assert_equal(8,  console.get_col_size('currency'))
    assert_equal(21, console.get_col_size('operation_type'))
    assert_equal(19, console.get_col_size('time'))
    assert_equal(7,  console.get_col_size('comment'))

    hash1 = {'id'=>'1228945898091',
             'amount'=>'0.06037590',
             'balance_after'=>'0.06037590',
             'currency'=>'btc',
             'operation_type'=>'+currency_transaction',
             'time'=>'2017-11-08 18:47:40',
             'comment'=>''}


    assert_equal('1228945898091', console.get_value(1,'id'))
    assert_equal('0.06037590', console.get_value(1,'amount'))
    assert_equal('0.06037590', console.get_value(1,'balance_after'))
    assert_equal('btc', console.get_value(1,'currency'))
    assert_equal('+currency_transaction', console.get_value(1,'operation_type'))
    assert_equal('2017-11-08 18:47:40', console.get_value(1,'time'))
    assert_equal('', console.get_value(1,'comment'))


    assert_equal('1228945898091', console.get_value_nice(1,'id'))
    assert_equal('0.06037590', console.get_value_nice(1,'amount'))
    assert_equal('   0.06037590', console.get_value_nice(1,'balance_after'))
    assert_equal('     btc', console.get_value_nice(1,'currency'))
    assert_equal('+currency_transaction', console.get_value_nice(1,'operation_type'))
    assert_equal('2017-11-08 18:47:40', console.get_value_nice(1,'time'))
    assert_equal('       ', console.get_value_nice(1,'comment'))
    assert_equal('1228945898091', console.get_value_nice(1,'id'))


  end

end