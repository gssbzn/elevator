# Elevator
[![Build Status](https://travis-ci.org/gssbzn/elevator.svg?branch=master)](https://travis-ci.org/gssbzn/elevator)
[![Coverage Status](https://coveralls.io/repos/gssbzn/elevator/badge.svg?branch=master&service=github)](https://coveralls.io/github/gssbzn/elevator?branch=master)

A simple simulation of an elevator, have fun traveling with it

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'elevator' git: 'https://github.com/gssbzn/elevator.git'
```

And then execute:

    $ bundle

## Usage

As simple as:

```ruby
elevator = Elevator::Elevator.new ['1', '2', '3', '4']
elevator.mark_floor '4'
elevator.start_moving
```

You can customize what happens on each floor the elevator visits,
you just have to implement and observer that extends [Elevator::Observer](lib/elevator/observer.rb)
```ruby
elevator = Elevator::Elevator.new ['1', '2', '3', '4']
Elevator::DoorOpener.new elevator
elevator.mark_floor '4'
elevator.start_moving
```
Will output
```
doors open at 4
```

## Contributing

1. Fork it ( https://github.com/gssbzn/elevator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
