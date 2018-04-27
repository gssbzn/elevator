# frozen_string_literal: true

require 'spec_helper'
require 'elevator/elevator'
describe Elevator::DoorOpener do
  let(:elevator) { Elevator::Elevator.new %w[1 2 3] }
  subject { Elevator::DoorOpener.new(elevator) }
  describe 'update' do
    before :each do
      elevator.mark_floor('2')
    end
    it 'triggers update from observer' do
      expect(subject).to receive(:update).with('2', true).once
      elevator.start_moving
    end
    it 'open doors on marked floor' do
      expect(subject).to receive(:open_doors).with('2').once
      elevator.start_moving
    end
    it 'outputs open doors on marked floor' do
      subject
      expect { elevator.start_moving }.to output("doors open at 2\n").to_stdout_from_any_process
    end
  end
end
