require_relative 'toy_robot/simulator'

module ToyRobot

  def self.activate
    ToyRobot::Simulator.new(STDOUT)
  end

end