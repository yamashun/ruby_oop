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

class TripTest < MiniTest::Test
  def test_request_trip_preparation
    @preparer = MiniTest::Mock.new
    @trip = Trip.new
    @preparer.expect(:prepare_trip, nil, [@trip])

    @trip.prepare([@preparer])
    @preparer.verify
  end
end
