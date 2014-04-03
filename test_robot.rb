#!/usr/bin/env ruby 

$LOAD_PATH.unshift File.expand_path('../lib',__FILE__)
require 'simulator'

simulator = Simulator.new(STDOUT)

while user_request = gets.chomp
   break if (user_request.upcase == "QUIT" || user_request.upcase == "EXIT")
   simulator.execute(user_request)
   puts simulator.report
end



