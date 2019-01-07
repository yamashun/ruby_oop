class Schedule
  def scheduled?(schedulable, start_date, end_date)
    puts "Thisn #{schedulable.class} is not scheduled\n" +
      " between #{start_date} and #{end_date}"
    false
  end
end

module Schedulable
  attr_reader :schedule

  def schedule
    @schedule ||= ::Schedule.new
  end

  def schedulable?(start_date, end_date)
    !scheduled?(start_date - lead_days, end_date)
  end

  def scheduled?(start_date, end_date)
    schedule.scheduled?(self, start_date, end_date)
  end

  def lead_days
    0
  end
end

class Bicycle
  include Schedulable

  attr_reader :schedule, :size, :chain, :tire_size

  def initialize(args={})
    @schedule = args[:schedule] || Schedule.new
    @size = args[:size]
    @chain = args[:chain] || derault_chain
    @tire_size = args[:tire_size] || default_tire_size

    post_initialize(args)
  end

  def post_initialize(args)
    nil
  end

  def lead_days
    1
  end

  def spares
    {
      tire_size: tire_size,
      chain: chain,
    }.merge(local_spares)
  end

  def local_spares
    {}
  end

  def derault_chain
    '10-speed'
  end

  def default_tire_size
    '23'
  end
end


require 'date'

starting = Date.parse('2018/09/04')
ending = Date.parse('2018/09/10')

b = Bicycle.new
puts b.schedulable?(starting, ending)
