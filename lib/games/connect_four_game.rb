class ConnectFourGame

  attr_accessor :game_board

  def initialize
    #game board for now is going to be columns X rows
    @game_board = Array.new(ENV['MAX_COLUMNS'].to_i) { Array.new }
   end

  def record_users_move(column)
    raise ColumnFull.new if is_column_full?(column)

    take_slot(column, "human")
  end

  def make_computers_move
    find_possible_computer_moves
  end

  def did_user_win?(owner)
    check_board_for_streaks(owner) >= 4
  end

  private

  def should_block?
  end

  def streak_count(column, row, direction, owner)
     if is_row_valid?(column, row) && is_column_valid?(column) 
      if @game_board[column][row].user == owner

        next_row = row if direction == 'horizontal'
        next_row = row + 1 if ['vertical', 'diagonal up'].include? direction
        next_row = row -1 if direction == 'diagonal down'

        next_column = column if direction == 'vertical'
        next_column = column + 1 if ['horizontal', 'diagonal up'].include? direction
        next_column = column - 1 if direction == 'diagonal down' 
        
        current_count = streak_count(next_column, next_row, direction, owner)
        current_count = 1 if current_count.nil?
        current_count += 1
      end
    end
    current_count ||= 1
  end

  
  
  def take_slot(column, owner)
     @game_board[column] << Slot.new(owner)
  end

  def is_column_full?(column)
    return false if @game_board[column].nil?
    @game_board[column].count >= ENV['MAX_ROWS'].to_i
  end

  def check_board_for_streaks(owner)
    match_count = 0
    @game_board.each do |column|
      column.each do |row|
        if owner == row.user
          current_row = column.index(row)
          current_column = @game_board.index(column)
          
          vertical_count = streak_count(current_column, current_row + 1, "vertical", owner)
          horizontal_count = streak_count(current_column + 1, current_row, "horizontal", owner)
          up_count = streak_count(current_column + 1, current_row + 1, "diagonal up", owner)
          down_count = streak_count(current_column - 1, current_row - 1, "diagonal down", owner)
          match_count = [match_count, vertical_count, horizontal_count, up_count, down_count].max
         end
      end
    end

    match_count
  end

  def find_possible_computer_moves

    possible_moves = Array.new
    @game_board.each do |column|
      column.each do |row|
        if row.user == 'human'
          current_row = column.index(row)
          current_column = @game_board.index(column)
          
          vertical_count = streak_count(current_column,
                                        current_row + 1,
                                        'vertical',
                                        'human')

          possible_moves << log_possible_moves(current_column, current_row, vertical_count, 'vertical') if vertical_count > 2
          
          horizontal_count = streak_count(current_column + 1,
                                          current_row,
                                          'horizontal',
                                          'human')
          puts horizontal_count
          
          possible_moves << log_possible_moves(current_column, current_row, horizontal_count, 'horizontal') if horizontal_count > 2
          
          up_count = streak_count(current_column + 1,
                                  current_row + 1,
                                  'diagonal up',
                                  'human')

          possible_moves << log_possible_moves(current_column, current_row, up_count, 'diagonal up') if up_count > 2
          
          
          down_count = streak_count(current_column - 1,
                                    current_row - 1,
                                    'diagonal down',
                                    'human')

          possible_moves << log_possible_moves(current_column, current_row, down_count, 'diagonal down') if down_count > 2

          puts possible_moves
        end
    #check to see if current count of the human is 3
    #for each one store column of possible blocks
    #check to see if the slot is available to block
    #store the column row coordinate in an array?

    #user similar code to check for streaks but instead return coords
    #create am arrray with coordinates and then add to the beginning if a higher streak and at the end if lower
    #find the max streak
    #when found the max streak, store column that started it
    #check to see if the slot is availabe to block
    #take opportunity
      end
    end
  end

  def log_possible_moves(column, row, count, direction)
    {
      :count => count,
      :direction => direction,
      :coord => [column, row]
    }
  end
  

  def is_row_valid?(column, row)
    row >= 0 && row < ENV['MAX_ROWS'].to_i && row < @game_board[column].count
  end

  def is_column_valid?(column)
    column >= 0 && column < ENV['MAX_COLUMNS'].to_i
  end
end
