require 'spec_helper'

describe ConnectFourGame do

  it 'should initialize a new game board' do

    game = ConnectFourGame.new

  end

  it 'should take a new slot' do
    game = ConnectFourGame.new
    game.record_users_move(3)

    expect(game.game_board[3].count).to eq 1
    expect(game.game_board[0].count).to eq 0
  end

  it 'should find a winning horizontal row' do
    game = ConnectFourGame.new
    puts game.inspect
    
    game.game_board[1] << Slot.new('human')
    game.game_board[1] << Slot.new('computer')
    game.game_board[2] << Slot.new('computer')
    game.game_board[2] << Slot.new('computer')
    game.game_board[3] << Slot.new('human')
    game.game_board[3] << Slot.new('computer')
    game.game_board[4] << Slot.new('human')
    game.game_board[4] << Slot.new('computer')

    game.did_user_win?
    
    puts game.inspect
  end
  
end
