require_relative '../spec_helper'

describe ReaRobot::Placement do
  describe '.new' do
    it 'initialises a new Placement if direction is valid' do
      VALID_DIRECTIONS = %w(NORTH EAST SOUTH WEST)
      VALID_DIRECTIONS.each do |f|
        placement = described_class.new(1, 2, f)
        expect(placement).to_not be_nil
      end
    end

    it 'raises an error if direction is not invalid' do
      INVALID_DIRECTIONS = ['N', 'n', ' ', '%', 'North', 'north', '1', nil]
      INVALID_DIRECTIONS.each do |f|
        expect{described_class.new(1, 2, f)}.to raise_error(ArgumentError, "Invalid direction given: #{f}")
      end
    end

  end
end
