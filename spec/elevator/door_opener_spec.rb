require 'spec_helper'
require 'elevator/elevator'
describe Elevator::DoorOpener do
  let(:elevator) { Elevator::Elevator.new ['1', '2'] }
  subject { Elevator::DoorOpener.new(elevator) }
  describe 'update' do
    before :each do
      elevator.mark_floor('2')
    end
    it 'open doors on marked floor' do
      expect(subject).to receive(:update).with('2', true).once
      elevator.start_moving
    end
  end
end
