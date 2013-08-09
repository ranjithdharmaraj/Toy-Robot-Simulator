#!/usr/bin/env ruby 

$LOAD_PATH.unshift File.expand_path('../lib',__FILE__)
require 'simulator'

simulator = Simulator.new(STDOUT)

while command = gets.chomp
   break if (command.upcase == "QUIT" || command.upcase == "EXIT")
   simulator.exec_command(command)
   puts simulator.report
end



