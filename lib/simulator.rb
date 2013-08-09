#!/usr/bin/env ruby
class Simulator

   attr_accessor :x, :y, :f

   def initialize(output)
      @output = output
      @output.puts 'Welcome to Robot Simulator!'
   end

   def place(x, y, f)
      return if f.nil?
      if valid_positions(x.to_i, y.to_i)
         @x = x.to_i
         @y = y.to_i
         @f = f.upcase
      end
   end

   def valid_positions(x, y)
      (x >= 0 && x <= 4 && y >= 0 && y <= 4)
   end

   def exec_command(cmd)
      return if cmd.strip.empty?
      cmd_split = cmd.split(/\s+/) 
      keyword   = cmd_split.first.upcase
      values    = cmd_split.last
      case keyword
      when 'PLACE'
         tokens    = values.split(/,/)
         place(tokens[0],tokens[1],tokens[2])
      when 'REPORT'
         puts report
      when 'MOVE'
         move_robot
      when 'LEFT'
         change_direction(keyword)
      when 'RIGHT'
         change_direction(keyword)
      when 'FILE'
         read_from_file(values)
      else
         #puts "Not a valid command #{keyword}"
      end
   end

   def report
      (@x.nil? && @y.nil?) ? "Robot not placed yet, please place the robot." : "Robot Co-ordinates => #{@x},#{@y},#{@f}"
   end
  
   def move_robot
      if (@f=~/NORTH/ && @y < 4)
        @y = (@y.to_i) + 1
      elsif (@f =~/SOUTH/ && @y > 0)
        @y = (@y.to_i) -1
      elsif (@f =~/EAST/ && @x < 4)
        @x= (@x.to_i) +1
      elsif (@f =~/WEST/ && @x > 0)
        @x= (@x.to_i) -1
      end
   end

   def change_direction(direction)
      if direction =~/LEFT/
         if @f=~/NORTH/
            @f="WEST"
         elsif @f =~/SOUTH/
            @f ="EAST"
         elsif @f =~/EAST/
            @f = "NORTH"
         elsif @f =~/WEST/
            @f ="SOUTH"
         end
      end
      if direction =~/RIGHT/
         if @f =~/NORTH/
            @f="EAST"
         elsif @f =~/SOUTH/
            @f ="WEST"
         elsif @f =~/EAST/
            @f = "SOUTH"
         elsif @f =~/WEST/
            @f ="NORTH"
         end
      end
   end
  
   def read_from_file(filename)
      begin
         fh = File.new(filename,"r")
	 while (line = fh.gets)
            sleep 1 
	    exec_command(line.chomp)
         end
         fh.close
      rescue => read_err
         puts "Exception when reading file: #{read_err}"
	 read_err  
      end
   end
end
