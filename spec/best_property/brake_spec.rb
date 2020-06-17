require 'rails_helper'

RSpec.describe BestProperty::Brake do
  describe 'symbol_to_index' do
    it { expect(described_class.new([:disc_ventilated, :drum, :disc]).symbol_to_index).to eq [2, 0, 1] }
  end

  describe 'Brake Type' do
    context 'with invalid or empty' do
      it { expect(described_class.new([nil, '', :invalid_brake_type]).best).to eq nil }
      it { expect(described_class.new([nil, '', :invalid_brake_type]).worst).to eq nil }

      it { expect(described_class.new([nil, '', :drum]).best).to eq :drum }
      it { expect(described_class.new([nil, '', :disc, :disc_ventilated]).worst).to eq :disc }
    end

    it { expect(described_class.new([:disc_ventilated, :drum, :disc]).best).to eq :disc_ventilated }
    
    it { expect(described_class.new([:drum, :disc]).best).to eq :disc }
    it { expect(described_class.new([:drum, :drum]).best).to eq :drum }

    it { expect(described_class.new([:drum, :disc, :disc_ventilated]).worst).to eq :drum }
  end
end