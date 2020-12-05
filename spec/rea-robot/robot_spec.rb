require_relative '../spec_helper'

describe ReaRobot::Robot do
  let!(:robot) { described_class.new(ReaRobot::Table.new(5, 5)) }

  describe '.new' do
    it 'raises an exception if a Table is not provided' do
      expect{described_class.new('Test')}.to raise_error
    end
  end

  describe '#direction' do
    context 'called on a new robot' do
      it 'raises an error' do
        expect{robot.direction}.to raise_error
      end
    end
    context 'called on a robot that has been placed' do
      before do
        robot.place(1, 2, 'NORTH')
      end
      it 'returns the direction of the robot' do
        expect(robot.direction).to eq('NORTH')
      end
    end
  end

  describe '#move' do
    context 'called on a new robot' do
      it 'raises an error' do
        expect{robot.direction}.to raise_error
      end
    end

    EDGE_CASES = [
        [4, 4, 'NORTH'],
        [4, 4, 'EAST'],
        [0, 0, 'SOUTH'],
        [0, 0, 'WEST']
    ]
    EDGE_CASES.each do |test_case|
      context "called on a robot placed at (#{test_case[0]}, #{test_case[1]}), facing #{test_case[2]}" do
        before do
          robot.place(test_case[0], test_case[1], test_case[2])
          robot.move
        end
        it 'does not change the position of the robot' do
          x, y = robot.position
          expect(x).to eq(test_case[0])
          expect(y).to eq(test_case[1])
        end
      end
    end

    context 'called on a robot that has been placed' do
      before do
        robot.place(1, 2, 'NORTH')
      end
      it 'returns a reference to the robot' do
        expect(robot.move).to eq(robot)
      end
    end

    context 'called on a robot that has been placed to face NORTH' do
      before do
        robot.place(1, 2, 'NORTH')
        robot.move
      end
      it 'moves the robot one unit to the NORTH' do
        _, y = robot.position
        expect(y).to eq(3)
      end
      it 'leaves the x position unchanged' do
        x, _ = robot.position
        expect(x).to eq(1)
      end
    end

    context 'called on a robot that has been placed to face EAST' do
      before do
        robot.place(1, 2, 'EAST')
        robot.move
      end
      it 'moves the robot one unit to the EAST' do
        x, _ = robot.position
        expect(x).to eq(2)
      end
      it 'leaves the y position unchanged' do
        _, y = robot.position
        expect(y).to eq(2)
      end
    end

    context 'called on a robot that has been placed to face SOUTH' do
      before do
        robot.place(1, 2, 'SOUTH')
        robot.move
      end
      it 'moves the robot one unit to the SOUTH' do
        _, y = robot.position
        expect(y).to eq(1)
      end
      it 'leaves the x position unchanged' do
        x, _ = robot.position
        expect(x).to eq(1)
      end
    end

    context 'called on a robot that has been placed to face WEST' do
      before do
        robot.place(1, 2, 'WEST')
        robot.move
      end
      it 'moves the robot one unit to the WEST' do
        x, _ = robot.position
        expect(x).to eq(0)
      end
      it 'leaves the y position unchanged' do
        _, y = robot.position
        expect(y).to eq(2)
      end
    end
  end

  describe '#place' do
    it 'returns a reference to the robot' do
      expect(robot.place(1, 1, 'NORTH')).to eq(robot)
    end
    context 'called on a new robot' do
      it 'places the robot on the table' do
        robot.place(1, 1, 'NORTH')
        expect(robot.placed?).to eq(true)
      end
      it 'raises an exception if the robot would be placed outside the table area' do
        INVALID_PLACEMENTS = [
            [-1, 0, 'NORTH'],
            [0, -1, 'EAST'],
            [5, 4, 'SOUTH'],
            [4, 5, 'WEST']
        ]
        INVALID_PLACEMENTS.each do |placement|
          expect{robot.place(placement[0], placement[1], placement[2])}.to raise_error
        end
      end
    end
  end

  describe '#placed?' do
    context 'called on a new robot' do
      it 'returns false' do
        expect(robot.placed?).to eq(false)
      end
    end
  end

  describe '#position' do
    context 'called on a new robot' do
      it 'raises an error' do
        expect{robot.direction}.to raise_error
      end
    end
    context 'called on a robot that has been placed' do
      before do
        robot.place(1, 2, 'NORTH')
      end
      it 'returns the direction of the robot' do
        x, y = robot.position
        expect(x).to eq(1)
        expect(y).to eq(2)
      end
    end
  end

  describe '#turn_left' do
    context 'called on a new robot' do
      it 'raises an error' do
        expect{robot.turn_left}.to raise_error
      end
    end

    direction_to_the_left = {
        'NORTH' => 'WEST',
        'EAST' => 'NORTH',
        'SOUTH' => 'EAST',
        'WEST' => 'SOUTH'
    }

    context 'called on a robot that has been placed' do
      direction_to_the_left.each do |first, second|
        context "to face #{first}" do
          before do
            robot.place(1, 2, first)
          end
          it "turns the robot to face the #{second}" do
            robot.turn_left
            expect(robot.direction).to eq(second)
          end
        end
      end
    end
  end

  describe '#turn_right' do
    context 'called on a new robot' do
      it 'raises an error' do
        expect{robot.turn_left}.to raise_error
      end
    end

    direction_to_the_right = {
        'NORTH' => 'EAST',
        'EAST' => 'SOUTH',
        'SOUTH' => 'WEST',
        'WEST' => 'NORTH'
    }

    context 'called on a robot that has been placed' do
      direction_to_the_right.each do |first, second|
        context "to face #{first}" do
          before do
            robot.place(1, 2, first)
          end
          it "turns the robot to face the #{second}" do
            robot.turn_right
            expect(robot.direction).to eq(second)
          end
        end
      end
    end
  end

end
