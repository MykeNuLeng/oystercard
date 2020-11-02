class Oystercard

  def initialize(default_balance = 0)
    @balance = default_balance
  end

  attr_reader :balance 

end
