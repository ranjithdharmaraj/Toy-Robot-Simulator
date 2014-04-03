require_relative "lib/toy_robot.rb"

task :activate do

	@robot = ToyRobot.activate

	while user_request = gets.chomp
	   break if (user_request.upcase == "QUIT" || user_request.upcase == "EXIT")
	   @robot.execute(user_request)
	   puts @robot.report
	end
end

task :default => :activate