class Oystercard

  def initialize(default_balance = 0)
    @balance = default_balance
  end

  attr_reader :balance

  def top_up(value)
    raise "You're clearly too rich!" if @balance + value > 90

    @balance += value
  end

end
