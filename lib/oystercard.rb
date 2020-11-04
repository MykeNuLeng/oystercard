require './lib/journey'
require './lib/station'
require './/lib/journey_log'
class Oystercard
  MINIMUM_BALANCE = 1
  MAXIMUM_BALANCE = 90
  MAXIMUM_ERROR = "#{MAXIMUM_BALANCE} is the balance limmit".freeze
  MINIMUM_ERROR = "You can't afford the minimum fare: #{MINIMUM_BALANCE}".freeze

  attr_reader :balance, :journeys, :journey_log

  def initialize(default_balance = 0)
    @balance = default_balance
    @journey_log = JourneyLog.new(journey_class: Journey)
  end

  def top_up(value)
    raise MAXIMUM_ERROR if @balance + value > MAXIMUM_BALANCE

    @balance += value
  end

  def touch_in(station)
    deduct(@journey_log.current_journey.fare) if @journey_log.current_journey

    raise MINIMUM_ERROR if @balance < MINIMUM_BALANCE

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
