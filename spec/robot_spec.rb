require 'spec_helper'

describe 'Robot Simulator' do
   
  describe 'Activate robot' do
    let(:robot) { ToyRobot.activate }

    it 'should be activated but not placed' do
      robot.placed.should be_false
    end
  end

  describe 'Start robot' do
    let(:robot) { ToyRobot::Simulator.new(STDOUT) }

    it 'should not be placed bt default' do
      robot.placed.should be_false
    end

    it 'should place the Robot in the default position 0,0 south-west corner facing NORTH' do
      robot.place
      robot.placed.should be_true
      robot.x_axis.should eq 0
      robot.y_axis.should eq 0
      robot.direction.should eq 'north'
    end

    it 'should move one unit forward from default position' do
      robot.place
      robot.move
      robot.x_axis.should eq 0
      robot.y_axis.should eq 1
      robot.direction.should eq 'north'
    end

    it 'should move backward when pointed south' do
      robot.place(1,1,'south')
      robot.move         
      robot.x_axis.should eq 1
      robot.y_axis.should eq 0
      robot.direction.should eq 'south'
    end

    it 'should move left when pointed west' do
      robot.place(1,1,'west')
      robot.move         
      robot.x_axis.should eq 0
      robot.y_axis.should eq 1
      robot.direction.should eq 'west'
    end

    it 'should move right when pointed east' do
      robot.place(1,1,'east')
      robot.move         
      robot.x_axis.should eq 2
      robot.y_axis.should eq 1
      robot.direction.should eq 'east'
    end

    it 'should report when asked' do
      robot.place
      robot.report.should =~ /My current co-ordinates/
    end
    
    it 'should change directions on command' do
      robot.place
      robot.move
      robot.change_direction('right').should eq 'east'
      robot.change_direction('left').should eq 'west' 
    end          

    it 'turning should point to correct direction when turned' do
      robot.place
      robot.move

      robot.execute('right')
      robot.direction.should eq 'east' 
      robot.execute('right')
      robot.direction.should eq 'south'
      robot.execute('right')
      robot.direction.should eq 'west'
      robot.execute('right')
      robot.direction.should eq 'north'

      robot.execute('left')
      robot.direction.should eq 'west'
      robot.execute('left')
      robot.direction.should eq 'south'
      robot.execute('left')
      robot.direction.should eq 'east'
      robot.execute('left')
      robot.direction.should eq 'north'          
    end         

    it 'should interpret command and actions' do
      robot.execute('place 1,1,NORTH')

      robot.execute('REPORT')

      robot.execute('MOVE')
      robot.execute('REPORT')

      robot.execute('LEFT')
      robot.execute('REPORT')
      
      robot.execute('MOVE')
      robot.execute('REPORT')

      robot.x_axis.should be 0
      robot.y_axis.should be 2
      robot.direction.should eq 'west'            
    end

    it 'should not respond to invalid command' do
      robot.execute('HELLO')
    end
  end
end