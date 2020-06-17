require 'rails_helper'

RSpec.describe BestProperty::Detector do
  let(:cars) do 
    [
      FactoryGirl.build(
        :naked_car, 
        engine:         { max_power: 115, max_torque: 204 },
        operational:    { acceleration_0_100: 5.6, fuel_consumption_city: 8.0, fuel_consumption_highway: 5.9, fuel_consumption_mixed: 7 },
        brake:          { front: :drum, rear: :drum }
      ),

      FactoryGirl.build(
        :naked_car, 
        engine: { max_power: 315, max_torque: 120 },
        operational:    { acceleration_0_100: 7, fuel_consumption_city: 5.8, fuel_consumption_highway: 4.5, fuel_consumption_mixed: 5 },
        brake:          { front: :disc, rear: :drum }
      ),

      FactoryGirl.build(
        :naked_car, 
        engine: { max_power: 200, max_torque: 500 },
        operational:    { acceleration_0_100: 3.5, fuel_consumption_city: 10, fuel_consumption_highway: 8.7, fuel_consumption_mixed: 9 },
        brake:          { front: :disc_ventilated, rear: :disc }
      )
    ]
  end

  let(:detector)  { described_class.new(cars) }
  before          { detector.collect_properties }

  describe 'property collector' do
    describe 'engine' do
      context 'max_power' do
        it { expect(detector.collected[:engine][:max_power]).to eq [115, 315, 200] }
      end

      context 'max_torque' do
        it { expect(detector.collected[:engine][:max_torque]).to eq [204, 120, 500] }
      end
    end

    describe 'operational' do
      context 'acceleration_0_100' do
        it { expect(detector.collected[:operational][:acceleration_0_100]).to eq [5.6, 7, 3.5] }
      end

      context 'fuel_consumption' do
        it { expect(detector.collected[:operational][:fuel_consumption_city]).to eq [8.0, 5.8, 10] }
        it { expect(detector.collected[:operational][:fuel_consumption_highway]).to eq [5.9, 4.5, 8.7] }
        it { expect(detector.collected[:operational][:fuel_consumption_mixed]).to eq [7, 5, 9] }
      end

      context 'brake' do
        it { expect(detector.collected[:brake][:front]).to eq [:drum, :disc, :disc_ventilated] }
        it { expect(detector.collected[:brake][:rear]).to eq [:drum, :drum, :disc] }
      end
    end
  end

  describe 'detect' do
    context 'engine' do
      it { expect(detector.max_power).to eq 315 }
      it { expect(detector.max_torque).to eq 500 }
    end

    context 'operational' do
      it { expect(detector.acceleration_0_100).to eq 3.5 }
      it { expect(detector.fuel_consumption_city).to eq 5.8 }
      it { expect(detector.fuel_consumption_highway).to eq 4.5 }
      it { expect(detector.fuel_consumption_mixed).to eq 5 }
    end

    context 'brake' do
      it { expect(detector.front).to eq :disc_ventilated }
      it { expect(detector.rear).to eq :disc }
    end
  end
end