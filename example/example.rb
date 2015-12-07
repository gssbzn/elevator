require 'bundler/setup'
require 'elevator'

floors = [
  'B',
  'GF',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  'PH'
]

ELEVATOR = Elevator::Elevator.new floors
Elevator::DoorOpener.new(ELEVATOR)

loop do
  puts 'select a floor:'
  ELEVATOR.floors.each do |floor|
    puts "#{ELEVATOR.marked_floor?(floor) ? '*' : ' '}- #{floor}"
  end
  puts 'closedoors - start going'
  puts 'stepout - walk away from the elevator'
  input = gets.chomp
  case input
  when /stepout/
    break
  when /closedoors/
    ELEVATOR.start_moving
  else
    begin
      ELEVATOR.mark_floor(input)
    rescue ArgumentError
      puts "invalid option"
    end
  end
end

__END__
