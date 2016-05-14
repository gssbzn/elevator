# frozen_string_literal: true
require 'spec_helper'

describe Elevator::Elevator do
  let(:floors) { %w(1 2 3 4) }
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
      expect(subject.marked_floors).to match_array %w(3 2)
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
    context 'new instance' do
      it 'should be true' do
        expect(subject.up?).to be_truthy
      end
    end
    context 'going up' do
      before :each do
        subject.mark_floor('3')
        subject.start_moving
      end
      it 'should be true' do
        expect(subject.up?).to be_truthy
      end
    end
    context 'going down' do
      before :each do
        subject.mark_floor('4')
        subject.start_moving
        subject.mark_floor('2')
      end
      it 'should be false' do
        expect(subject.up?).to be_falsey
      end
    end
  end

  describe '#down?' do
    context 'new instance' do
      it 'should be false' do
        expect(subject.down?).to be_falsey
      end
    end
    context 'going up' do
      before :each do
        subject.mark_floor('3')
        subject.start_moving
      end
      it 'should be false' do
        expect(subject.down?).to be_falsey
      end
    end
    context 'going down' do
      before :each do
        subject.mark_floor('4')
        subject.start_moving
        subject.mark_floor('2')
        subject.start_moving
      end
      it 'should be true' do
        expect(subject.down?).to be_truthy
      end
    end
  end
  describe '#marked_floor?' do
    context 'with a marked floor' do
      it 'should be true for a valid marked floor' do
        subject.mark_floor('3')
        expect(subject.marked_floor?('3')).to be_truthy
      end
      it 'should be false for floor not marked' do
        subject.mark_floor('3')
        expect(subject.marked_floor?('2')).to be_falsey
      end
    end
    context 'without a marked floor' do
      it 'should be false' do
        expect(subject.marked_floor?('3')).to be_falsey
      end
    end
  end
end
