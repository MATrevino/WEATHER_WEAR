class Salary
  attr_reader :id, :type, :destination, :forecast, :salaries

  def initialize(destination, forecast, salaries)
    @id = 'null'
    @type = 'salaries'
    @destination = destination
    @forecast = forecast
    @salaries = salaries
  end
end