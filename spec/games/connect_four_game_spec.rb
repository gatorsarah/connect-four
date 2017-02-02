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
    
    game.game_board[1] << Slot.new('human')
    game.game_board[1] << Slot.new('computer')
    game.game_board[2] << Slot.new('computer')
    game.game_board[2] << Slot.new('computer')
    game.game_board[3] << Slot.new('human')
    game.game_board[3] << Slot.new('computer')
    game.game_board[4] << Slot.new('human')
    game.game_board[4] << Slot.new('computer')

    expect(game.did_user_win? 'computer').to be true
    expect(game.did_user_win? 'human').to be false
    
  end

   it 'should find a winning vertical row' do
    game = ConnectFourGame.new
    
    game.game_board[1] << Slot.new('human')
    game.game_board[2] << Slot.new('computer')
    game.game_board[2] << Slot.new('computer')
    game.game_board[2] << Slot.new('computer')
    game.game_board[2] << Slot.new('computer')
    game.game_board[3] << Slot.new('human')
    game.game_board[3] << Slot.new('computer')
    game.game_board[4] << Slot.new('human')

    expect(game.did_user_win? 'computer').to be true
    expect(game.did_user_win? 'human').to be false
    
   end

   it 'should find a winning horizontal up row' do
    game = ConnectFourGame.new
    
    game.game_board[1] << Slot.new('human')
    game.game_board[2] << Slot.new('computer')
    game.game_board[2] << Slot.new('human')
    game.game_board[2] << Slot.new('computer')
    game.game_board[2] << Slot.new('computer')
    game.game_board[3] << Slot.new('human')
    game.game_board[3] << Slot.new('computer')
    game.game_board[3] << Slot.new('human')
    game.game_board[4] << Slot.new('human')
    game.game_board[4] << Slot.new('human')
    game.game_board[4] << Slot.new('human')
    game.game_board[4] << Slot.new('human')

    expect(game.did_user_win? 'computer').to be false
    expect(game.did_user_win? 'human').to be true
    
   end


   it 'should take slots when needing to block' do
    game = ConnectFourGame.new
    
    game.game_board[1] << Slot.new('human')
    game.game_board[1] << Slot.new('human')
    game.game_board[2] << Slot.new('computer')
    game.game_board[2] << Slot.new('human')
    game.game_board[3] << Slot.new('human')
    game.game_board[3] << Slot.new('human')
    game.game_board[4] << Slot.new('human')

    expect(game.game_board[4].count).to be 1
    game.make_computers_move
 
    expect(game.game_board[4].count).to be 2
    expect(game.did_user_win? 'computer').to be false
    expect(game.did_user_win? 'human').to be false
    
   end

   it 'should take slots when needing to win' do
    game = ConnectFourGame.new
    
    game.game_board[1] << Slot.new('human')
    game.game_board[1] << Slot.new('computer')
    game.game_board[2] << Slot.new('computer')
    game.game_board[2] << Slot.new('computer')
    game.game_board[3] << Slot.new('human')
    game.game_board[3] << Slot.new('computer')
    game.game_board[4] << Slot.new('human')

    expect(game.game_board[4].count).to be 1
    game.make_computers_move

    expect(game.game_board[4].count).to be 2
    expect(game.did_user_win? 'computer').to be true
    expect(game.did_user_win? 'human').to be false
    
   end

   it 'should make a random move' do
    game = ConnectFourGame.new
    game.make_computers_move

    expect(game.did_user_win? 'computer').to be false
    expect(game.did_user_win? 'human').to be false
    
   end
   
end
