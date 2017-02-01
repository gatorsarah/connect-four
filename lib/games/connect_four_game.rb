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
  end

  def did_user_win?
    is_there_a_connect_four? 'computer'
  end

  private

  def should_block?
  end

  def streak_count(column, row, direction, owner)
 
    if is_row_valid?(column, row) && is_column_valid?(column) 

      if @game_board[column][row].user = owner

        next_row = row if direction == 'horizontal'
        next_row = row + 1 if ['vertical', 'diagonal up'].include? direction
        next_row = row -1 if direction == 'diagonal down'

        next_column = column if direction == 'vertical'
        next_column = column + 1 if ['horizontal', 'diagonal up'].include? direction
        next_column = column - 1 if direction == 'diagonal down' 
        
        current_count = streak_count(next_column, next_row, direction, owner)
        current_count = 1 if current_count.nil?
        current_count += 1

        puts "on the way back: #{current_count}"
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

  def is_there_a_connect_four?(owner)
    match_count = 0
    @game_board.each do |column|
      column.each do |row|
        if owner = row.user
          current_row = column.index(row)
          current_column = @game_board.index(column)
          vertical_count = streak_count(current_column, current_row + 1, "vertical", owner)
          horizontal_count = streak_count(current_column + 1, current_row, "horizontal", owner)
          up_count = streak_count(current_column + 1, current_row + 1, "diagonal up", owner)
          down_count = streak_count(current_column - 1, current_row - 1, "diagonal down", owner)
          match_count = [match_count, vertical_count, horizontal_count, up_count, down_count].max
          puts "Found #{match_count}"
        end
      end
    end
    puts "final_match_count #{match_count}"
    match_count
  end

  def is_row_valid?(column, row)
    row >= 0 && row < ENV['MAX_ROWS'].to_i && row < @game_board[column].count
  end

  def is_column_valid?(column)
    column >= 0 && column < ENV['MAX_COLUMNS'].to_i
  end
end
