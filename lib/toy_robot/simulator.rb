module ToyRobot
  class Simulator

    attr_accessor :x_axis, :y_axis, :direction, :placed

    def initialize std_out 
      placed  = false
      std_out.puts message
    end

    def place x=0,y=0,direction='north'
      if valid_position(x, y, direction)
        @x_axis = x
        @y_axis = y
        @direction = direction.downcase
        @placed = true
      end
    end

    def move
      case direction
      when 'north'
        forward
      when 'south'
        backward
      when 'east'
        right
      when 'west'
        left
      end
    end
     
    def report
      current_status
    end

    def change_direction turn
      map = {
            'left' => { 'north' => 'west',
                        'south' => 'east',
                        'east' => 'north',
                        'west' => 'south'},
            'right' => { 'north' => 'east',
                        'south' => 'west',
                        'east' => 'south',
                        'west' => 'north'},
            }
      map[turn][direction]
    end
    
  def execute(input)
    puts "Input: #{input}"
    if input.strip.length > 0
      command,values = input.split(/\s+/) 
      @x_axis,@y_axis,@direction = values.split(",") if values
      
      command.downcase!
      direction.downcase! if direction

      case command
      when /place/i
        place(@x_axis.to_i,@y_axis.to_i,direction)
      when /report/i
        puts report
      when /move/i
        move
      when /left|right/i
        @direction = change_direction(command)
      else
        puts no_command
      end
    end
  end

private
    
    def valid_coord input
      true if (0..4).include?(input.to_i)
    end

    def valid_direction input
      true if ['north','south','east','west'].include? input.to_s
    end

    def valid_position x, y, direction
      true if valid_coord(x) && valid_coord(y) && valid_direction(direction)
    end

    def forward
      @y_axis = y_axis + 1 if valid_coord(y_axis+1)
    end

    def backward
      @y_axis = y_axis - 1 if valid_coord(y_axis-1)      
    end

    def left
      @x_axis = x_axis - 1 if valid_coord(x_axis-1)
    end

    def right
      @x_axis = x_axis + 1 if valid_coord(x_axis+1)
    end
  
    def message
      'Hi, I am Max!. Lets play the game of squares on a 5x5 board. 
       I am intelligent enough not to fall off. TRY ME!!!!'
    end

    def current_status
      return "My current co-ordinates => X: #{x_axis}, Y: #{y_axis}, Moving: #{direction}"  
    end

    def no_command
      'I am not moving unless you ask me the right words!!!!'
    end
  end
end
