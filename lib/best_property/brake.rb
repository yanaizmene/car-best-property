class BestProperty::Brake < BestProperty
  def detect
    sti = symbol_to_index.compact
    return nil if sti.empty?

    yield(sti) if block_given?
  end

  def best
    detect{|values| brakes[values.max]}
  end

  def worst
    detect{|values| brakes[values.min]}
  end

  def brakes
    [ :drum, :disc, :disc_ventilated ]
  end

  def symbol_to_index
    @values.map{|v| brakes.index v}
  end
end