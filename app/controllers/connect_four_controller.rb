class ConnectFourController < ApplicationController

  def new_game
    @game = Games::ConnectFourGame.new

    session[:game_board] = @game.game_board
    #redirect_to :computers_move_path new
  end

  def make_computers_move
    @game = Games::ConnectFourGame.new

    @game.game_board = session[:game_board]
    @game.make_computers_move

    if @game.did_user_win? 'computer'
      session.delete(:game_board)
      redirect_to new_game_path, :notice => "Computer won! Starting new game!"
    else
      session[:game_board] = @game.game_board
      redirect_to users_move_path "choose"
    end
  end

  def users_move

    @game = Games::ConnectFourGame.new
    @game.game_board = session[:game_board]

    unless params[:column] == 'choose'
      @game.record_users_move params[:column].to_i
      session[:game_board] =  @game.game_board
      
      if @game.did_user_win? 'human'
        session.delete(:game_board)
        redirect_to new_game_path, :notice => "Congratulations!  Starting new game!"
      else
        session[:game_board] = @game.game_board
        redirect_to make_computers_move_path
      end
    end
  end

  def list_games
  end

  def load_game
  end

  def save_game

    game_board = session[:game_board]
    
    game_to_save = ConnectFourGame.create do |game|
      game.column0 = Array.new
      game.column1 = Array.new
      game.column2 = Array.new
      game.column3 = Array.new
      game.column4 = Array.new
      game.column5 = Array.new
      game.column6 = Array.new      
      
      game.save_time = DateTime.now
    end

      game_board[0].each { |item| game_to_save.column0 << item["user"]} 
      game_board[1].each { |item| game_to_save.column1 << item["user"]}
      game_board[2].each { |item| game_to_save.column2 << item["user"]}
      game_board[3].each { |item| game_to_save.column3 << item["user"]}
      game_board[4].each { |item| game_to_save.column4 << item["user"]}
      game_board[5].each { |item| game_to_save.column5 << item["user"]}
      game_board[6].each { |item| game_to_save.column6 << item["user"]}
      
  
    game_to_save.save!

    redirect_to new_game_path, :notice => "Game saved! Starting new game!"
  end
end
