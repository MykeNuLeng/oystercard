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
    raise "You don't have enough money" if @balance < MINIMUM_BALANCE

    @journey = Journey.new(station)
  end

  def touch_out(station)
    deduct(@journey.finish(station).fare)
    @travel_history << {
      entry_station: @journey.entry_station,
      exit_station: @journey.exit_station
    }
    @journey = nil
  end

  def in_journey?
   @journey != nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
