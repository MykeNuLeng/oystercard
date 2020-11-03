class Oystercard

  MINIMUM_BALANCE = 1


  def initialize(default_balance = 0, max = 90)
    @balance = default_balance
    @MAXIMUM_BALANCE = max
  end

  attr_reader :balance, :MAXIMUM_BALANCE, :entry_station

  def top_up(value)
    error = "You're clearly too rich! #{@MAXIMUM_BALANCE} is the limmit"
    raise error if @balance + value > @MAXIMUM_BALANCE

    @balance += value
  end

  def touch_in(station)
    raise "You don't have enough money" if @balance < MINIMUM_BALANCE

    raise "You didn't touch out, shame on you!" if in_journey?

    @entry_station = station
  end

  def touch_out
    raise "You didn't touch in, shame on you!" if !in_journey?

    deduct(MINIMUM_BALANCE)
    @entry_station = nil
  end

  def in_journey?
   @entry_station != nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
