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

  private

  def should_block?
  end

  def on_a_streak?
  end

  def take_slot(column, owner)
     @game_board[column] << Slot.new(owner)
   end

  def is_column_full?(column)
    return false if @game_board[column].nil?
    @game_board[column].count >= ENV['MAX_ROWS'].to_i
  end

  def is_there_a_connect_four?
  end
end
