class Journey

  PENALTY_FARE = 6
  STANDARD_FARE = 1

  attr_reader :entry_station, :exit_station

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station
  end

  def fare
    return PENALTY_FARE if !finished?

    return STANDARD_FARE
  end

  def finished?
    @exit_station != nil
  end

  def finish(exit_station)
    @exit_station = exit_station
    self
  end
end
