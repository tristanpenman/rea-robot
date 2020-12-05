require_relative '../spec_helper'

describe ReaRobot::Table do
  describe '.new' do
    context 'initialising a new Table with valid dimensions' do
      VALID_DIMENSIONS = [
          [1, 2],
          [2, 1],
          [5, 5],
          ['5', '5']
      ]
      VALID_DIMENSIONS.each do |dimensions|
        table = described_class.new(dimensions[0], dimensions[1])
        it 'returns a valid instance' do
          expect(table).to_not be_nil
        end
        it 'allows the width passed in at initialisation to be retrieved as an integer' do
          expect(table.width).to eq(dimensions[0].to_s.to_i)
        end
        it 'allows the height passed in at initialisation to be retrieved as an integer' do
          expect(table.height).to eq(dimensions[1].to_s.to_i)
        end
      end
    end
    it 'raises an exception if dimensions are invalid' do
      INVALID_DIMENSIONS = [
          [0, 0],
          [0, 1],
          [1, 0],
          [1, -1],
          [-1, 1],
          ['a', 'b'],
          ['1', 'b'],
          ['a', '2'],
          [nil, 1],
          [nil, nil],
          [1, nil]
      ]
      INVALID_DIMENSIONS.each do |dimensions|
        expect{described_class.new(dimensions[0], dimensions[1])}.to raise_error
      end
    end
  end
end
