class BestProperty::Detector
  attr_reader :collected

  def initialize(cars)
    @cars = cars
    collect_properties
  end

  def collect_properties
    @collected = Hash.new

    collects.each_pair do |property, parameters|
      @collected[property] = Hash.new

      parameters.each do |papam|
        @collected[property][papam] = @cars.map do |car|
          car.send(property).send(papam)
        end    
      end
    end
  end

  def max_power
    BestProperty::Engine.new(@collected[:engine][:max_power]).max_power
  end

  def max_torque
    BestProperty::Engine.new(@collected[:engine][:max_torque]).max_torque
  end

  def acceleration_0_100
    BestProperty::Operational.new(@collected[:operational][:acceleration_0_100]).acceleration
  end

  def fuel_consumption_city
    BestProperty::Operational.new(@collected[:operational][:fuel_consumption_city]).fuel_consumption_city
  end

  def fuel_consumption_highway
    BestProperty::Operational.new(@collected[:operational][:fuel_consumption_highway]).fuel_consumption_highway
  end

  def fuel_consumption_mixed
    BestProperty::Operational.new(@collected[:operational][:fuel_consumption_mixed]).fuel_consumption_mixed
  end

  def max_speed
    BestProperty::Operational.new(@collected[:operational][:max_speed]).max_speed
  end

  def front
    return nil if @collected[:brake][:front].compact.uniq.size == 1
    BestProperty::Brake.new(@collected[:brake][:front]).best
  end

  def rear
    return nil if @collected[:brake][:rear].compact.uniq.size == 1
    BestProperty::Brake.new(@collected[:brake][:rear]).best
  end

private
  def collects
    {
      engine:         [:max_power, :max_torque],
      operational:    [:acceleration_0_100, :max_speed, :fuel_consumption_city, :fuel_consumption_highway, :fuel_consumption_mixed],
      brake:          [:front, :rear]
    }
  end  
end