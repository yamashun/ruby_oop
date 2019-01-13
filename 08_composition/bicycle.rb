require 'forwardable'

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
  extend Forwardable
  def_delegators :@parts, :size, :each
  include Enumerable

  def initialize(parts)
    @parts = parts
  end

  def spares
    select{|part| part.needs_spare }
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

module PartsFactory
  def self.build(config, part_class = Part, parts_class = Parts)
    parts_class.new(
      config.collect{|part_config|
        part_class.new(
          name: part_config[0],
          description: part_config[1],
          needs_spare: part_config.fetch(2, true)
        )
      }
    )
  end
end

chain = Part.new(name: 'chain', description: '10-speed')
road_tire = Part.new(name: 'tire_size', description: '23')
tape = Part.new(name: 'tape_color', description: 'red')
mountain_tire = Part.new(name: 'tire_size', description: '2.1')
rear_shock = Part.new(name: 'rear_shock', description: 'Fox')
front_shock = Part.new(name: 'front_shock', description: 'Maintou', needs_spare: false)

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

puts road_bike.parts.size
puts mountain_bike.parts.size


road_config = [
  ['chain', '10-speed'], ['tire_size', '23'], ['tape_color', 'red']
]

mountain_config = [
  ['chain', '10-speed'], ['tire_size', '2.1'], ['front_shock', 'Maintou', false], ['rear_shock', 'FOX']
]

road_parts = PartsFactory.build(road_config)
puts road_parts
mountain_parts = PartsFactory.build(mountain_config)
puts mountain_parts
