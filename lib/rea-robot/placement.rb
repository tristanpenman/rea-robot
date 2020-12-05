module ReaRobot

  ##
  # Represents the position and direction of a Robot
  #
  # x and y should be non-negative integers, and f (direction) should one of the following strings:
  #
  #  - NORTH
  #  - EAST
  #  - SOUTH
  #  - WEST
  #
  class Placement
    attr_reader :x_offset, :y_offset, :direction

    ##
    # Create a Placement instance to describe the placement of a Robot
    #
    # x_offset and y_offset will be parsed as integers, and must be greater or equal to zero.
    #
    # direction must be 'NORTH', 'EAST', 'SOUTH' or 'WEST'.
    #
    def initialize(x_offset, y_offset, direction)
      @x_offset = validate_offset(x_offset)
      @y_offset = validate_offset(y_offset)
      @direction = validate_direction(direction)
    end

  private_methods

    ##
    # Raises an ArgumentError if the value is not a valid direction
    #
    # Returns the value otherwise
    #
    def validate_direction(value)
      valid_directions = %w(NORTH EAST SOUTH WEST)
      unless valid_directions.include?(value)
        raise ArgumentError, "Invalid direction given: #{value}"
      end
      value
    end

    ##
    # Raises an ArgumentError if the value cannot be parsed a non-negative (>=0) integer
    #
    # Returns the value as an Integer otherwise
    #
    def validate_offset(value)
      value = value.to_s
      unless value.match(/\A-?\d+\Z/) and value.to_i >= 0
        raise ArgumentError, "Expected integral value greater than or equal to zero: #{value}"
      end
      value.to_i
    end

  end
end