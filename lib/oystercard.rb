require './lib/journey'
require './lib/station'
require './/lib/journey_log'
class Oystercard
  MINIMUM_BALANCE = 1
  MAXIMUM_BALANCE = 90
  BALANCE_ERROR = "#{MAXIMUM_BALANCE} is the balance limmit".freeze

  attr_reader :balance, :journeys, :journey_log

  def initialize(default_balance = 0)
    @balance = default_balance
    @journey_log = JourneyLog.new(journey_class: Journey)
  end

  def top_up(value)
    raise BALANCE_ERROR if @balance + value > MAXIMUM_BALANCE

    @balance += value
  end

  def touch_in(station)
    deduct(@journey_log.current_journey.fare) if @journey_log.current_journey

    raise "You don't have enough money" if @balance < MINIMUM_BALANCE

    @journey_log.start(station)
  end

  def touch_out(station)
    @journey_log.current_journey ? @journey_log.finish(station) : @journey_log.start(nil, station)

    deduct(@journey_log.final_journey.fare)
  end

  def in_journey?
    !!@journey_log.current_journey
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
