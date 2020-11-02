class Oystercard

  def initialize(default_balance = 0, min = 1, max = 90)
    @balance = default_balance
    @MINIMUM_BALANCE = min
    @MAXIMUM_BALANCE = max
    @in_or_out = 0
  end

  attr_reader :balance, :MINIMUM_BALANCE, :MAXIMUM_BALANCE

  def top_up(value)
    raise "You're clearly too rich! #{@MAXIMUM_BALANCE} is the limmit" if @balance + value > @MAXIMUM_BALANCE

    @balance += value
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    raise "You don't have enough balance for a journey" if @balance < @MINIMUM_BALANCE

    raise "You didn't touch out, shame on you!" if @in_or_out == 1

    @in_or_out += 1
  end

  def touch_out
    raise "You didn't touch in, shame on you!" if @in_or_out == 0

    @in_or_out -= 1
  end

  def in_journey?
    return true if @in_or_out == 1

    return false
  end

end
