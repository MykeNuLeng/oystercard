class Journey

  PENALTY_FARE = 6
  STANDARD_FARE = 1

  attr_reader :entry_station, :exit_station

  def initialize(entry_station, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def fare
    return PENALTY_FARE if penalty?

    return STANDARD_FARE
  end

  def finish(exit_station)
    @exit_station = exit_station
    self
  end

  private 

  def penalty?
    !@entry_station || !@exit_station
  end
end
