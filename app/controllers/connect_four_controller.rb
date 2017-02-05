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
        redirect_to new_game_path, :notice => "Congratulations!  Starting new game!"
      else
        session[:game_board] = @game.game_board
        redirect_to make_computers_move_path
      end
    end
  end
end
