class Oystercard

  def initialize(default_balance = 0, max = 90)
    @balance = default_balance
    @MAXIMUM_BALANCE = max
    @in_or_out = 0
  end

  attr_reader :balance, :MAXIMUM_BALANCE

  def top_up(value)
    raise "You're clearly too rich! #{@MAXIMUM_BALANCE} is the limmit" if @balance + value > @MAXIMUM_BALANCE

    @balance += value
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    @in_or_out += 1
  end

end
