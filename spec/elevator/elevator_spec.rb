require 'spec_helper'

describe Elevator::Elevator do
  let(:floors) { ['1', '2', '3', '4'] }

  describe '#new' do
    subject { Elevator::Elevator.new floors }
    it 'takes a list of floors' do
      expect(subject).to be_an_instance_of(Elevator::Elevator)
    end
    it 'sets the list of floors' do
      expect(subject.floors).to eq(floors)
    end
    it 'sets current_floor to first of the list' do
      expect(subject.current_floor).to eq(floors.first)
    end
    it 'sets direction to "up"' do
      expect(subject.direction).to eq('up')
    end
    it 'raises an ArgumentError if floors params is not kind of an Enumerable' do
      expect { Elevator::Elevator.new 'hi' }.to raise_error(ArgumentError)
    end
    it 'raises an ArgumentError if floors params is not kind of an Enumerable' do
      expect { Elevator::Elevator.new 0 }.to raise_error(ArgumentError)
    end
  end

  describe '#mark_floor' do
    subject { Elevator::Elevator.new floors }
    it 'add floors to marked_floors' do
      subject.mark_floor('3')
      subject.mark_floor('2')
      expect(subject.marked_floors).to match_array ['3', '2']
    end
    it 'should not repeat floors on marked_floors' do
      subject.mark_floor('3')
      subject.mark_floor('3')
      expect(subject.marked_floors).to match_array ['3']
    end
    it "raises an ArgumentError if floor doesn't exists" do
      expect { subject.mark_floor('7') }.to raise_error(ArgumentError)
    end
  end

  describe '#start_moving' do
    it 'moves the elevator to the third floor' do
      elevator = Elevator::Elevator.new floors
      elevator.mark_floor('3')
      expect(elevator).to receive(:notify_observers).with('2', false).once
      expect(elevator).to receive(:notify_observers).with('3', true).once
      elevator.start_moving
    end
    it 'takes you to a fun ride' do
      elevator = Elevator::Elevator.new floors
      elevator.mark_floor('4')
      expect(elevator).to receive(:notify_observers).with('2', false).once
      expect(elevator).to receive(:notify_observers).with('3', false).once
      expect(elevator).to receive(:notify_observers).with('4', true).once
      elevator.start_moving
      elevator.mark_floor('1')
      expect(elevator).to receive(:notify_observers).with('3', false).once
      expect(elevator).to receive(:notify_observers).with('2', false).once
      expect(elevator).to receive(:notify_observers).with('1', true).once
      elevator.start_moving
    end
  end

  describe '#up?' do
    it 'should be true when new' do
      elevator = Elevator::Elevator.new floors
      expect(elevator.up?).to be_truthy
    end
    it 'should be true when going up' do
      elevator = Elevator::Elevator.new floors
      elevator.mark_floor('3')
      elevator.start_moving
      expect(elevator.up?).to be_truthy
    end
    it 'should be false when going down' do
      elevator = Elevator::Elevator.new floors
      elevator.mark_floor('4')
      elevator.start_moving
      elevator.mark_floor('2')
      expect(elevator.up?).to be_falsey
    end
  end

  describe '#down?' do
    it 'should be false when new' do
      elevator = Elevator::Elevator.new floors
      expect(elevator.down?).to be_falsey
    end
    it 'should be false when going up' do
      elevator = Elevator::Elevator.new floors
      elevator.mark_floor('3')
      elevator.start_moving
      expect(elevator.down?).to be_falsey
    end
    it 'should be true when going down' do
      elevator = Elevator::Elevator.new floors
      elevator.mark_floor('4')
      elevator.start_moving
      elevator.mark_floor('2')
      elevator.start_moving
      expect(elevator.down?).to be_truthy
    end
  end
end
