class Bicycle
  attr_reader :size, :parts

  def initialize(args={})
    @size = args[:size]
    @parts = args[:parts]
  end

  def spares
    parts.spares
  end
end

class Parts
  attr_reader :parts

  attr_reader :size, :chain, :tire_size

  def initialize(parts)
    @parts = parts
  end

  def spares
    parts.select{|part| part.needs_spare}
  end
end

class Part
  attr_reader :name, :description, :needs_spare

  def initialize(args)
    @name = args[:name]
    @description = args[:description]
    @needs_spare = args.fetch(:needs_spare, true)
  end
end

# class RoadBikeParts < Parts
#   attr_reader :tape_color

#   def post_initialize(args)
#     @tape_color = args[:tape_color]
#   end

#   def local_spares
#     { tape_color: tape_color }
#   end

#   def default_tire_size
#     '23'
#   end
# end

# class MountainBikeParts < Parts
#   attr_reader :front_shock, :rear_shock

#   def post_initialize(args)
#     @front_shock = args[:front_shock]
#     @rear_shock = args[:rear_shock]
#   end

#   def local_spares
#     { rear_shock: rear_shock }
#   end

#   def default_tire_size
#     '2.1'
#   end
# end

# road_bike = Bicycle.new(
#   size: 'L',
#   parts: RoadBikeParts.new(tape_color: 'red')
# )
# puts road_bike.size
# puts road_bike.spares

# mountain_bike = Bicycle.new(
#   size: 'L',
#   parts: MountainBikeParts.new(rear_shock: 'Fox')
# )

# puts mountain_bike.size
# puts mountain_bike.spares



chain = Part.new(name: 'chain', description: '10-speed')
road_tire = Part.new(name: 'tire_size', description: '23')
tape = Part.new(name: 'tape_color', description: 'red')
mountain_tire = Part.new(name: 'tire_size', description: '2.1')
rear_shock = Part.new(name: 'rear_shock', description: 'Fox')
front_shock = Part.new(name: 'front_shock', description: 'Maintou', need_spare: false)

road_bike_parts = Parts.new([chain, road_tire, tape])
road_bike = Bicycle.new(size: 'L', parts: road_bike_parts)

puts road_bike.size
puts road_bike.spares

mountain_bike = Bicycle.new(
  size: 'L',
  parts: Parts.new([chain, mountain_tire, front_shock, rear_shock])
)

puts mountain_bike.size
puts mountain_bike.spares
