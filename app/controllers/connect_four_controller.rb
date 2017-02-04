class ConnectFourController < ApplicationController
  
  def new_game
    @game = Games::ConnectFourGame.new

    #redirect_to :computers_move_path new
  end

  def computers_move
    @game.make_computers_move

    #render board
    
    did_user_win? 'computer'
    #if so, then popup contrats message 
  end

  def users_move
    @game.record_users_move params[:column]

    #render choice
    
    if did_user_win? 'human'
    #if so then popup contrats message
    else
      render computers_move_path
    end
  end
end
