require_relative '../spec_helper'

describe ReaRobot::Simulator do
  let!(:simulator) { described_class.new }

  describe '#parse' do
    context 'called with the commands provided in REA\'s first example' do
      input = [
          'PLACE 0,0,NORTH',
          'MOVE',
          'REPORT'
      ]
      it 'produces the expected output' do
        last_result = nil
        input.each { |line| last_result = simulator.parse(line) }
        expect(last_result).to eq('0,1,NORTH')
      end
    end

    context 'called with the commands provided in REA\'s second example' do
      input = [
          'PLACE 0,0,NORTH',
          'LEFT',
          'REPORT'
      ]
      it 'produces the expected output' do
        last_result = nil
        input.each { |line| last_result = simulator.parse(line) }
        expect(last_result).to eq('0,0,WEST')
      end
    end

    context 'called with the commands provided in REA\'s third example' do
      input = [
          'PLACE 1,2,EAST',
          'MOVE',
          'MOVE',
          'LEFT',
          'MOVE',
          'REPORT'
      ]
      it 'produces the expected output' do
        last_result = nil
        input.each { |line| last_result = simulator.parse(line) }
        expect(last_result).to eq('3,3,NORTH')
      end
    end

    context 'called with a variation of REA\'s third example to test turning right' do
      input = [
          'PLACE 1,2,EAST',
          'MOVE',
          'MOVE',
          'RIGHT',
          'MOVE',
          'REPORT'
      ]
      it 'produces the expected output' do
        last_result = nil
        input.each { |line| last_result = simulator.parse(line) }
        expect(last_result).to eq('3,1,SOUTH')
      end
    end

    context 'called with a series of commands that will test the NORTH boundary' do
      input = [
          'PLACE 0,4,NORTH',
          'MOVE',
          'REPORT'
      ]
      it 'produces the expected output' do
        last_result = nil
        input.each { |line| last_result = simulator.parse(line) }
        expect(last_result).to eq('0,4,NORTH')
      end
    end

    context 'called with a series of commands that will test the EAST boundary' do
      input = [
          'PLACE 4,0,EAST',
          'MOVE',
          'REPORT'
      ]
      it 'produces the expected output' do
        last_result = nil
        input.each { |line| last_result = simulator.parse(line) }
        expect(last_result).to eq('4,0,EAST')
      end
    end

    context 'called with a series of commands that will test the SOUTH boundary' do
      input = [
          'PLACE 0,0,SOUTH',
          'MOVE',
          'REPORT'
      ]
      it 'produces the expected output' do
        last_result = nil
        input.each { |line| last_result = simulator.parse(line) }
        expect(last_result).to eq('0,0,SOUTH')
      end
    end

    context 'called with a series of commands that will test the WEST boundary' do
      input = [
          'PLACE 0,0,WEST',
          'MOVE',
          'REPORT'
      ]
      it 'produces the expected output' do
        last_result = nil
        input.each { |line| last_result = simulator.parse(line) }
        expect(last_result).to eq('0,0,WEST')
      end
    end

    context 'called with a PLACE command missing the final argument' do
      it 'raises an exception' do
        expect{simulator.parse('PLACE 4,4')}.to raise_error
      end
    end

    context 'called with a PLACE command containing an invalid x coordinate' do
      it 'raises an exception' do
        input = [
            'PLACE 5,0,NORTH',
            'PLACE -1,0,EAST',
            'PLACE a,0,SOUTH',
            'PLACE -,0,WEST'
        ]
        input.each do |line|
          expect{simulator.parse(line)}.to raise_error
        end
      end
    end

    context 'called with a PLACE command containing a invalid y coordinate' do
      it 'raises an exception' do
        input = [
            'PLACE 0,5,NORTH',
            'PLACE 0,-1,EAST',
            'PLACE 0,a,SOUTH',
            'PLACE 0,-,WEST'
        ]
        input.each do |line|
          expect{simulator.parse(line)}.to raise_error
        end
      end
    end

    context 'called with a PLACE command containing an invalid direction' do
      it 'raises an exception' do
        input = [
            'PLACE 0,1,north',
            'PLACE 2,3,e',
            'PLACE 4,4,E',
            'PLACE 4,1,3'
        ]
        input.each do |line|
          expect{simulator.parse(line)}.to raise_error
        end
      end
    end

    context 'called with a PLACE command for a position that is not within the bounds of the table' do
      before do
        expect{simulator.parse('PLACE 5,5,NORTH')}.to raise_error
      end
      it 'does not place the robot' do
        expect(simulator.parse('REPORT')).to be_nil
      end
    end

  end
end
