class ConnectFourGame

  attr_accessor :game_board

  def initialize
    #game board for now is going to be columns X rows
    @game_board = [][]
    
  end

  def record_users_move(column)
    raise ColumnFull.new if is_column_full?

    
  end

  def make_computers_move
  end

  private

  def should_block?
  end

  def on_a_streak?
  end

  def take_slot
  end

  def is_column_full?(column)
    @game_board[column].count >= ENV['MAX_ROWS']
  end
  
end
