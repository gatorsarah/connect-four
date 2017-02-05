class ConnectFourGame < ActiveRecord::Base

  validates :save_time, presence: true
  validates_uniqueness_of :save_time


  def restore_row_data

    game = Games::ConnectFourGame.new

    column0.each { |item| game.game_board[0] << {"user" => item}}
    column1.each { |item| game.game_board[1] << {"user" => item}}
    column2.each { |item| game.game_board[2] << {"user" => item}}
    column3.each { |item| game.game_board[3] << {"user" => item}}
    column4.each { |item| game.game_board[4] << {"user" => item}}
    column5.each { |item| game.game_board[5] << {"user" => item}}
    column6.each { |item| game.game_board[6] << {"user" => item}}

    game
  end
  
  
end
