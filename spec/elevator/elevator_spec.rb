require 'spec_helper'

describe Elevator::Elevator do
  let(:floors) { ['1', '2', '3', '4'] }
  subject { Elevator::Elevator.new floors }
  describe '#new' do
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
      subject.mark_floor('3')
      expect(subject).to receive(:notify_observers).with('2', false).once
      expect(subject).to receive(:notify_observers).with('3', true).once
      subject.start_moving
    end
    it 'takes you to a fun ride' do
      subject.mark_floor('4')
      expect(subject).to receive(:notify_observers).with('2', false).once
      expect(subject).to receive(:notify_observers).with('3', false).once
      expect(subject).to receive(:notify_observers).with('4', true).once
      subject.start_moving
      subject.mark_floor('1')
      expect(subject).to receive(:notify_observers).with('3', false).once
      expect(subject).to receive(:notify_observers).with('2', false).once
      expect(subject).to receive(:notify_observers).with('1', true).once
      subject.start_moving
    end
  end

  describe '#up?' do
    it 'should be true when new' do
      expect(subject.up?).to be_truthy
    end
    it 'should be true when going up' do
      subject.mark_floor('3')
      subject.start_moving
      expect(subject.up?).to be_truthy
    end
    it 'should be false when going down' do
      subject.mark_floor('4')
      subject.start_moving
      subject.mark_floor('2')
      expect(subject.up?).to be_falsey
    end
  end

  describe '#down?' do
    it 'should be false when new' do
      expect(subject.down?).to be_falsey
    end
    it 'should be false when going up' do
      subject.mark_floor('3')
      subject.start_moving
      expect(subject.down?).to be_falsey
    end
    it 'should be true when going down' do
      subject.mark_floor('4')
      subject.start_moving
      subject.mark_floor('2')
      subject.start_moving
      expect(subject.down?).to be_truthy
    end
  end
end
