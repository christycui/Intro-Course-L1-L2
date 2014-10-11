# OOP part1 Ex. 1

module CarryPeople

end

class Vehicle
  @@n_of_object = 0
  def initialize(y,c,m)
    @year = y
    @color = c
    @model = m
    @@n_of_object += 1
  end

  def n_of_object
  end
end

class MyCar < Vehicle
  include CarryPeople
  attr_accessor :year, :color, :model

  def initialize(y, c, m)
    super(y,c,m)
    @speed = 0
  end

  TOTAL_PASSENGER = 5

  def speed=(n)
    @speed = speed
  end

  def to_s
    "This car is a #{color} #{year} #{model}, driving at a speed of #{@speed}."
  end
end

class MyTruck < Vehicle
  TOTAL_FREIGHT = 1000
end
car = MyCar.new('2013', 'metallic blue', 'Mini Cooper Countryman')
puts car
car.speed="20"
puts car
