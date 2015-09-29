class Route

  attr_accessor(:origin, :destiny, :distance)

  def initialize(origin, destiny, distance)
    @origin = origin
    @destiny = destiny
    @distance = distance
  end

  def stops
    @origin.split('-').count
  end

  def to_s
    distance
  end
end
