class ObscuringReferences
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def diameters
    # 0はリム、1はタイヤ
    data.collect { |cell|
      cell[0] + (cell[1] * 2)
    }
  end
end
