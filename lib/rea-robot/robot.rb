require_relative 'table'
require_relative 'placement'

module ReaRobot

  ##
  # Represents a current state of a toy robot, relative to a Table surface
  #
  class Robot

    ##
    # Create a new Robot on a given Table surface
    #
    # table must refer to an instance of Table
    #
    def initialize(table)
      raise ArgumentError, "Expected instance of Table, got: #{table.class.name}" unless table.is_a? Table
      @placement = nil
      @table = table
    end

    ##
    # Return the direction that the robot is currently facing
    #
    # Raises an exception if the robot has not yet been placed on the table
    #
    def direction
      raise_unless_placed
      @placement.direction
    end

    ##
    # Move the robot one unit in the direction that it is currently facing
    #
    # Raises an exception if the robot has not yet been placed on the table
    #
    def move
      raise_unless_placed
      position = Robot.find_next_position(@placement)
      position[0] = [[position[0], 0].max, @table.width - 1].min
      position[1] = [[position[1], 0].max, @table.height - 1].min
      @placement = Placement.new(position[0], position[1], @placement.direction)
      self
    end

    ##
    # Place a robot on the table, facing a given direction
    #
    # x_offset and y_offset must be integers greater than or equal to zero, but refer to positions that are within
    # the bounds of the Table surface
    #
    # direction must be 'NORTH', 'EAST', 'SOUTH' or 'WEST'.
    #
    # Raises an exception if the robot has not yet been placed on the table
    #
    def place(x_offset, y_offset, direction)
      @previous_placement = @placement
      @placement = Placement.new(x_offset, y_offset, direction)
      unless @placement.x_offset.between?(0, @table.width - 1)
        @placement = @previous_placement
        raise "Invalid x position (not on table surface): #{x_offset}"
      end
      unless @placement.y_offset.between?(0, @table.height - 1)
        @placement = @previous_placement
        raise "Invalid y position (not on table surface): #{y_offset}"
      end
      self
    end

    ##
    # Returns a boolean indicating whether the robot has been placed on the table
    #
    def placed?
      @placement != nil
    end

    ##
    # Returns two values, indicating the current x and y offsets of the robot
    #
    # Raises an exception if the robot has not yet been placed on the table
    #
    def position
      raise_unless_placed
      return @placement.x_offset, @placement.y_offset
    end

    ##
    # Rotates the robot to face the direction 90 degrees to the left
    #
    # Raises an exception if the robot has not yet been placed on the table
    #
    def turn_left
      raise_unless_placed
      direction_to_the_left = {
          'NORTH' => 'WEST',
          'EAST' => 'NORTH',
          'SOUTH' => 'EAST',
          'WEST' => 'SOUTH'
      }
      @placement = Placement.new(@placement.x_offset, @placement.y_offset,
                                 direction_to_the_left.fetch(@placement.direction))
      self
    end

    ##
    # Rotates the robot to face the direction 90 degrees to the right
    #
    # Raises an exception if the robot has not yet been placed on the table
    #
    def turn_right
      raise_unless_placed
      direction_to_the_right = {
          'NORTH' => 'EAST',
          'EAST' => 'SOUTH',
          'SOUTH' => 'WEST',
          'WEST' => 'NORTH'
      }
      @placement = Placement.new(@placement.x_offset, @placement.y_offset,
                                 direction_to_the_right.fetch(@placement.direction))
      self
    end

  private_methods

    def self.find_next_position(placement)
      case placement.direction
        when 'NORTH'
          [placement.x_offset, placement.y_offset + 1]
        when 'EAST'
          [placement.x_offset + 1, placement.y_offset]
        when 'SOUTH'
          [placement.x_offset, placement.y_offset - 1]
        when 'WEST'
          [placement.x_offset - 1, placement.y_offset]
        else
          raise RuntimeError, "Unrecognised direction in current placement: #{placement.direction}"
      end
    end

    ##
    # Raise an exception if the robot has not yet been placed on the table
    #
    def raise_unless_placed
      raise 'Robot has not been placed' unless @placement
    end

  end
end
