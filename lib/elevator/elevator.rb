require 'observer'

# A simple simulation of an Elevator
module Elevator
  # Elevator class, store a list of floors,
  # allows you to mark floors and move through them
  class Elevator
    include ::Observable

    # @!attribute [r] floors
    #   @return [Array] list of elevator floors
    attr_reader :floors
    # @!attribute [r] current_floor
    #   @return [Object] elevator current floor
    attr_reader :current_floor
    # @!attribute [r] direction
    #   @return [Object] direction the elevator is traveling
    attr_reader :direction
    # @!attribute [r] marked_floors
    #   @return [Array] selected floors for travel
    attr_reader :marked_floors

    # New Elevator instance
    # @param floors [Array] list of floors the elevator has in the correct order
    def initialize(floors)
      enumerable_floors?(floors)
      @floors = floors
      @current_floor = @floors.first
      @direction = 'up'.freeze
      @marked_floors = []
    end

    # Select a floor to go
    # @param floor [Object] a valid floor
    def mark_floor(floor)
      floor_exists?(floor)
      return if current_floor == floor || marked_floors.include?(floor)
      @marked_floors << floor
    end

    # Move the elevator through the selected floors
    def start_moving
      return if marked_floors.empty?
      init_direction
      move
    end

    # Is the elevator going up?
    # @return true if direction is up
    def up?
      direction == 'up'.freeze
    end

    # Is the elevator going down?
    # @return true if direction is down
    def down?
      direction == 'down'.freeze
    end

    # Is the floor marked to go
    # @param floor [Object] a valid floor
    # @return true if floor is marked
    def marked_floor?(floor = nil)
      floor ||= @current_floor
      marked_floors.include? floor
    end

    private

    def init_direction
      if floors.index(marked_floors.first) > floors.index(current_floor)
        @direction = 'up'.freeze
      else
        @direction = 'down'.freeze
      end
    end

    def change_direction
      @direction = up? ? 'down'.freeze : 'up'.freeze
    end

    def can_continue?(i)
      !(i >= (floors.size - 1) || i < 0)
    end

    def move
      i = floors.index(current_floor)
      loop do
        i += up? ? 1 : -1
        go_floor(i)
        change_direction unless can_continue?(i)
        break unless marked_floors.any?
      end
    end

    def go_floor(i)
      @current_floor = floors.at(i)
      changed
      notify_observers(current_floor, marked_floor?)
      marked_floors.delete @current_floor
    end

    def enumerable_floors?(floors)
      return if floors.is_a? Enumerable
      fail ArgumentError, "floors must be Enumerable: #{floors.inspect}"
    end

    def floor_exists?(floor)
      return if floors.include? floor
      fail ArgumentError, "selected floor doesn't exists: #{floor}"
    end
  end
end
