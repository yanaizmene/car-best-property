class BestProperty::Operational < BestProperty
  def fuel_consumption_city
    @values.min
  end

  def fuel_consumption_highway
    @values.min
  end

  def fuel_consumption_mixed
    @values.min
  end

  def acceleration
    @values.min
  end

  def max_speed
    @values.max
  end
end