require 'minitest/autorun'
require './wheel.rb'

class DameterDouble
  def diameter
    10
  end
end

class WheelTest < MiniTest::Unit::TestCase
  def test_calculate_diameter
    wheel = Wheel.new(26, 1.5)

    assert_in_delta(29, wheel.diameter, 0.01)
  end
end


class GearTest < MiniTest::Unit::TestCase
  def test_calculates_gear_inches
    gear = Gear.new(
      chainring: 52,
      cog: 11,
      wheel: DameterDouble.new
    )

    assert_in_delta(47.27, gear.gear_inches, 0.01)
  end
end

