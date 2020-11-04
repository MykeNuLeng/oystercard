class Station
  attr_reader :zone, :name

  def initialize
    @zone = [1, 2, 3, 4, 5].sample
    @name = ["Bond Street", "Brixton", "Canary Wharf", "Hammersmith"].sample
  end
end
