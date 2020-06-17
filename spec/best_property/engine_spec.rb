require 'rails_helper'

RSpec.describe BestProperty::Engine do
  describe 'Max Power' do
    it { expect(described_class.new([98, 115, 200]).max_power).to eq 200 }
  end

  describe 'Max Torque' do
    it { expect(described_class.new([200, 550, 350]).max_torque).to eq 550 }
  end
end