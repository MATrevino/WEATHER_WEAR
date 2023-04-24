class Salary
  attr_reader :id, :type, :destination, :forecast, :salary

  def initialize(destination, forecast, salary)
    @id = 'null'
    @type = 'salaries'
    @destination = destination
    @forecast = forecast
    @salary = salary
  end
end