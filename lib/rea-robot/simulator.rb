require_relative 'robot'

module ReaRobot

  ##
  # Updates and reports on the current state of a simulated toy robot
  #
  # Currently hard-coded to create a robot on a Table of size 5x5
  #
  class Simulator

    ##
    # Set up a new simulation on a table of size 5x5
    #
    def initialize
      @robot = Robot.new(Table.new(5, 5))
    end

    ##
    # Parse a command that could update or report on the state of the simulated toy robot
    #
    # Supports the following commands:
    #
    #  - PLACE x,y,direction
    #  - LEFT
    #  - RIGHT
    #  - MOVE
    #  - REPORT
    #
    # Returns nil if the state was updated successfully, or a string if reporting on the current state. Spacing between
    # arguments to the PLACE command ignored.
    #
    # Raises an exception if the command was invalid.
    #
    def parse(command)
      case command
        when /\APLACE\s+(-?\d+)\s*,\s*(-?\d+)\s*,\s*([A-Z]+)\z/
          @robot.place($1, $2, $3)
        when /\AMOVE\z/
          if @robot.placed?
            @robot.move
          end
        when /\ALEFT\z/
          if @robot.placed?
            @robot.turn_left
          end
        when /\ARIGHT\z/
          if @robot.placed?
            @robot.turn_right
          end
        when /\AREPORT\z/
          if @robot.placed?
            x, y = @robot.position
            d = @robot.direction
            return "#{x},#{y},#{d}"
          end
        else
          raise "Unrecognised command: #{command}"
      end
      nil
    end
  end
end
