# Ex 7.

class Student
  attr_accessor :name
  attr_writer :grade

  def initialize(name, grade)
    @name = name
    @grade = grade
  end
  def better_grade_than?(person)
    if grade > person.grade
      true
    else
      false
    end
  end
  
  protected
  attr_reader :grade

end

joe = Student.new('Joe', 99)
bob = Student.new('Bob', 98)
puts "Well done!" if joe.better_grade_than?(bob)
