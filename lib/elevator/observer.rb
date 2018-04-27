# frozen_string_literal: true

module Elevator
  # Generic Observer for when the elevator changes floor
  class Observer
    def initialize(elevator)
      elevator.add_observer(self)
    end
  end
end
