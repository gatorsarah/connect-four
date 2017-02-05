module Games
class ConnectFourGame

    attr_accessor :game_board

    def initialize
      #game board for now is going to be columns X rows
      @game_board = Array.new(ENV['MAX_COLUMNS'].to_i) { Array.new }
    end

    def record_users_move(column)
      raise ColumnFull.new if is_column_full?(column)

      take_slot(column, 'human')
    end

    def make_computers_move
      #check to see if we need to block first
      moves_needed_for_blocking = find_possible_computer_moves('human')

      moves_needed_for_blocking.each do |move|
        return if made_move? move
      end

      moves_for_making_a_streak = find_possible_computer_moves 'computer'
      moves_for_making_a_streak.each do |move|
        return if made_move? move
      end

      # No suggested moves - go random!
      random = Random.new
      take_slot(random.rand(0..6), 'computer')
    end

    def did_user_win?(owner)
      check_board_for_streaks(owner) >= 4
    end

    private

    def find_possible_computer_moves(owner)
      possible_moves = Array.new

      streak_count_check = 1 if owner == 'computer'
      streak_count_check = 2 if owner == 'human'
      
      @game_board.each do |column|
        column.each do |row|
          if get_user(row)  == owner
            current_row = column.index(row)
            current_column = @game_board.index(column)
            
            vertical_count = streak_count(current_column, current_row + 1, 'vertical', owner)
            possible_moves << log_possible_moves(current_column, current_row, vertical_count, 'vertical') if vertical_count > streak_count_check
            
            horizontal_count = streak_count(current_column + 1, current_row, 'horizontal', owner)
            possible_moves << log_possible_moves(current_column, current_row, horizontal_count, 'horizontal') if horizontal_count > streak_count_check
            
            up_count = streak_count(current_column + 1, current_row + 1, 'diagonal up', owner)
            possible_moves << log_possible_moves(current_column, current_row, up_count, 'diagonal up') if up_count > streak_count_check
            
            down_count = streak_count(current_column - 1, current_row - 1, 'diagonal down', owner)
            possible_moves << log_possible_moves(current_column, current_row, down_count, 'diagonal down') if down_count > streak_count_check
          end
        end
      end
      possible_moves
    end

    def find_column_at_back_of_streak(move)
      column = "none"

      column_to_check = move[:coord][0] if move[:direction] == 'vertical'
      column_to_check = move[:coord][0] + move[:count] if ['horizontal', 'diagonal_up'].include? move[:direction]
      column_to_check = move[:coord][0] - move[:count] if move[:direction] == 'diagonal down'

      if is_column_valid?(column_to_check) && is_new_row_valid?(column_to_check, move[:coord][1])
        unless move[:direction] == 'vertical'
          if is_new_row_smart?(column_to_check, move[:coord][1])
            column = column_to_check
          end
        else
          column = column_to_check
        end
      end
      column
    end

    def find_column_at_front_of_streak(move)
      column = "none"

      column_to_check = move[:coord][0] if move[:direction] == 'vertical'
      column_to_check = move[:coord][0] - 1 if ['horizontal', 'diagonal_up'].include? move[:direction]
      column_to_check = move[:coord][0] + 1 if move[:direction] == 'diagonal down'

      if is_column_valid?(column_to_check) && is_new_row_valid?(column_to_check, move[:coord][1])
        column = column_to_check
      end
      column
    end

    def check_board_for_streaks(owner)
      match_count = 0
      @game_board.each do |column|
        column.each do |row|
          if owner == get_user(row)
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

    def streak_count(column, row, direction, owner)
      if is_column_valid?(column) && is_row_valid?(column, row)
        if @game_board[column][row]["user"] == owner

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
    
    def made_move?(move)
      back_of_streak_column = find_column_at_back_of_streak move
      
      unless back_of_streak_column == "none"
        take_slot(back_of_streak_column, 'computer')
        return true 
      end

      front_of_streak_column = find_column_at_front_of_streak move
      unless front_of_streak_column == "none"
        take_slot(front_of_streak_column, 'computer')
        return true
      end
      false
    end
    
    def take_slot(column, owner)
      @game_board[column] << {"user" => owner}
    end

    def is_column_full?(column)
      return false if @game_board[column].nil?
      @game_board[column].count >= ENV['MAX_ROWS'].to_i
    end

    def log_possible_moves(column, row, count, direction)
      {
        :count => count,
        :direction => direction,
        :coord => [column, row]
      }
    end  

    def is_row_valid?(column, row)
      row >= 0 && row < ENV['MAX_ROWS'].to_i && row < @game_board[column].count #&& row + 1 >= @game_board[column].count
    end

    def is_new_row_valid?(column, row)
      @game_board[column].count + 1 < ENV['MAX_ROWS'].to_i
    end

    def is_new_row_smart?(column, row)
      row + 1 > @game_board[column].count
    end

    def is_column_valid?(column)
      column >= 0 && column < ENV['MAX_COLUMNS'].to_i
    end

    def get_user(row)
      if row.is_a? Hash
        user = row["user"]
      else
        user = row.user
      end
      user
    end
  end
end
