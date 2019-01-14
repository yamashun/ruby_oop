require 'minitest/autorun'
require './prepare.rb'
require './prepare_interface.rb'


class MechanicTest < MiniTest::Test
  include PrepareInterfaceTest

  def setup
    @mechanic = @object = Mechanic.new
  end
end

class TripCoordinatorTest < MiniTest::Test
  include PrepareInterfaceTest

  def setup
    @trip_coordinator = @object = TripCoordinator.new
  end
end


class DriverTest < MiniTest::Test
  include PrepareInterfaceTest

  def setup
    @driver = @object = Driver.new
  end
end
