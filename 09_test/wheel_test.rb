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

  def setup
    @observer = MiniTest::Mock.new
    @gear = Gear.new(
      chainring: 52,
      cog: 11,
      observer: @observer
    )
  end

  def test_notifies_observers_when_cogs_changed
    @observer.expect(:changed, true, [52, 27])
    @gear.set_cog(27)
    @observer.verify
  end

  def test_notifies_observers_when_chainrings_changed
    @observer.expect(:changed, true, [42, 11])
    @gear.set_chainring(42)
    @observer.verify
  end

  # def test_calculates_gear_inches
  #   gear = Gear.new(
  #     chainring: 52,
  #     cog: 11,
  #     wheel: DameterDouble.new
  #   )

  #   assert_in_delta(47.27, gear.gear_inches, 0.01)
  # end
end

