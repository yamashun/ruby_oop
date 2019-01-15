require 'minitest/autorun'
require './wheel.rb'

module DiameterizableInterfaceTest
  def test_implements_the_diameterizable_interface
    assert_respond_to(@object, :width)
  end
end


# class DameterDouble
#   def diameter
#     10
#   end
# end

class WheelTest < MiniTest::Unit::TestCase
  include DiameterizableInterfaceTest

  def setup
    @wheel = @object = Wheel.new(26, 1.5)
  end

  def test_calculate_diameter
    assert_in_delta(29, @wheel.width, 0.01)
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

