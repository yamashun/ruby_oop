class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(args={})
    @size = args[:size]
    @chain = args[:chain] || derault_chain
    @tire_size = args[:tire_size] || default_tire_size
  end

  def spares
    {
      tire_size: tire_size,
      chain: chain,
    }
  end

  def derault_chain
    '10-speed'
  end

  def default_tire_size
    raise NotImplementedError, "This #{self.class} cannot respond to"
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def initialize(args)
    @tape_color = args[:tape_color]
    super(args)
  end

  def spares
    super.merge(tape_color: tape_color)
  end

  def default_tire_size
    '23'
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
    super(args)
  end

  def spares
    super.merge(rear_shock: rear_shock)
  end

  def default_tire_size
    '2.1'
  end
end

class RecumbentBike < Bicycle
  def derault_chain
    '9-speed'
  end
end

road_bike = RoadBike.new(
  size: 'M',
  tape_color: 'red'
)

puts road_bike.size
puts road_bike.spares

mountain_bike = MountainBike.new(
  size: 'S',
  front_shock: 'Maintou',
  rear_shock: 'Fox'
)

puts mountain_bike.size
puts mountain_bike.spares
