module ReaRobot

  ##
  # Represents the width and height of a table
  #
  class Table
    attr_reader :width, :height

    ##
    # Create a play table of a given width and height
    #
    # width and height will be parsed as integers, and must be greater than zero
    #
    def initialize(width, height)
      @width = validate_extent(width)
      @height = validate_extent(height)
    end

  private_methods

    ##
    # Raises an ArgumentError if the value cannot be parsed a positive (>0) integer
    #
    # Returns the value as an Integer otherwise
    #
    def validate_extent(value)
      value = value.to_s
      unless value.match(/\A\d+\Z/) and value.to_i > 0
        raise ArgumentError, "Expected integral value greater than zero: #{value}"
      end
      value.to_i
    end

  end
end
