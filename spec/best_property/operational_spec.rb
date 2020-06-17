require 'rails_helper'

RSpec.describe BestProperty::Operational do
  describe 'Acceleration' do
    it { expect(described_class.new([nil, 9, 8.1]).acceleration).to eq 8.1 }
    it { expect(described_class.new([5.3, 9, 8.1]).acceleration).to eq 5.3 }
  end

  describe 'Fuel Consumption' do
    it { expect(described_class.new([8.7, nil, 10]).fuel_consumption_city).to eq 8.7 }
  end
end