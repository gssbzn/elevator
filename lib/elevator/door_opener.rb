module Elevator
  # Especific Observer to handle elevator doors
  class DoorOpener < ElevatorObserver
    # Observer callback
    def update(floor, marked_floor)
      open_doors(floor) if marked_floor
    end

    protected

    # Open elevator doors
    def open_doors(floor)
      puts "doors open at #{floor}"
    end
  end
end
