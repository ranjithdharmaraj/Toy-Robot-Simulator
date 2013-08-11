#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path('../',__FILE__)

require 'spec_helper'

describe 'Robot Simulator' do
   describe 'Start robot' do
      let(:simulator) {Simulator.new(STDOUT)}
      it 'should place the Robot in the default position 0,0 south-west corneri facing NORTH' do
         place_robot
         simulator.x.should eq 0
         simulator.y.should eq 0
         simulator.f.should eq 'NORTH'
      end

      it 'should move one unit forward from default position' do
         place_robot
         simulator.move_robot
         simulator.x.should eq 0
         simulator.y.should eq 1
         simulator.f.should eq 'NORTH'
      end

      it 'should output the co-ordinates' do
         place_robot
         simulator.report.should eq "Robot Co-ordinates => 0,0,NORTH"
      end
 
      it 'should change directions on command' do
         place_robot
         simulator.move_robot
         simulator.change_direction('RIGHT')
         simulator.report.should eq "Robot Co-ordinates => 0,1,EAST"
         simulator.change_direction('LEFT')
         simulator.report.should eq "Robot Co-ordinates => 0,1,NORTH"
      end          
    
      it 'show correct direction facing when turned right' do
	 simulator.place(2,2,'NORTH')
         simulator.change_direction('RIGHT')
         simulator.report.should eq "Robot Co-ordinates => 2,2,EAST"
         simulator.change_direction('RIGHT')
         simulator.report.should eq "Robot Co-ordinates => 2,2,SOUTH"
         simulator.change_direction('RIGHT')
         simulator.report.should eq "Robot Co-ordinates => 2,2,WEST"
         simulator.change_direction('RIGHT')
         simulator.report.should eq "Robot Co-ordinates => 2,2,NORTH"
      end

      it 'show correct direction facing when turned left' do
         simulator.place(2,2,'NORTH')
         simulator.change_direction('LEFT')
         simulator.report.should eq "Robot Co-ordinates => 2,2,WEST"
         simulator.change_direction('LEFT')
         simulator.report.should eq "Robot Co-ordinates => 2,2,SOUTH"
         simulator.change_direction('LEFT')
         simulator.report.should eq "Robot Co-ordinates => 2,2,EAST"
         simulator.change_direction('LEFT')
         simulator.report.should eq "Robot Co-ordinates => 2,2,NORTH"
      end

      it 'should ignore faulty commands' do
         place_robot
         simulator.place(4,4,'NORTH')
         simulator.move_robot 
         simulator.change_direction('RIGHT')
         simulator.report.should eq 'Robot Co-ordinates => 4,4,EAST'
         simulator.move_robot
         simulator.report.should eq 'Robot Co-ordinates => 4,4,EAST'
 
         simulator.place(0,0,'NORTH')
         simulator.change_direction('LEFT')
         simulator.report.should eq 'Robot Co-ordinates => 0,0,WEST'
         simulator.move_robot
         simulator.report.should eq 'Robot Co-ordinates => 0,0,WEST'

         simulator.place(4,0,'EAST')
         simulator.move_robot
         simulator.report.should eq 'Robot Co-ordinates => 4,0,EAST'

         simulator.place(0,4,'NORTH')
         simulator.move_robot
         simulator.report.should eq 'Robot Co-ordinates => 0,4,NORTH'

         simulator.place(4,2,'EAST')
         simulator.move_robot
         simulator.report.should eq 'Robot Co-ordinates => 4,2,EAST'

         simulator.place(2,0,'SOUTH')
         simulator.move_robot
         simulator.report.should eq 'Robot Co-ordinates => 2,0,SOUTH'
      end
   end
end

def place_robot
  simulator.place(0,0,'NORTH')
end
