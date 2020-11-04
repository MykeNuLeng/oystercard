require './lib/journey.rb'
require './lib/station.rb'
class Oystercard

  MINIMUM_BALANCE = 1


  def initialize(default_balance = 0, max = 90)
    @balance = default_balance
    @MAXIMUM_BALANCE = max
    @travel_history = []
    @journey
  end

  attr_reader :balance, :MAXIMUM_BALANCE, :travel_history

  def top_up(value)
    error = "You're clearly too rich! #{@MAXIMUM_BALANCE} is the limmit"
    raise error if @balance + value > @MAXIMUM_BALANCE

    @balance += value
  end

  def touch_in(station)
    end_journey if @journey

    raise "You don't have enough money" if @balance < MINIMUM_BALANCE

    @journey = Journey.new(station)
  end

  def touch_out(station)
    @journey = Journey.new(nil) unless @journey

    @journey.finish(station)
    end_journey
  end

  def in_journey?
   @journey != nil
  end

  private

  def end_journey
    deduct(@journey.fare)
    @travel_history << @journey
    @journey = nil
  end

  def deduct(fare)
    @balance -= fare
  end

end
