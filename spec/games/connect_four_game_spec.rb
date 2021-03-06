require 'spec_helper'

describe Games::ConnectFourGame do

  it 'should initialize a new game board' do
    game = Games::ConnectFourGame.new
  end

  it 'should take a new slot' do
    game = Games::ConnectFourGame.new
    game.record_users_move(3)

    expect(game.game_board[3].count).to eq 1
    expect(game.game_board[0].count).to eq 0
  end

  it 'should find a winning horizontal row' do
    game = Games::ConnectFourGame.new
    
    game.game_board[1] << {'user' => 'human'}
    game.game_board[1] << {'user' => 'computer'}
    game.game_board[2] << {'user' => 'computer'}
    game.game_board[2] << {'user' => 'computer'}
    game.game_board[3] << {'user' => 'human'}
    game.game_board[3] << {'user' => 'computer'}
    game.game_board[4] << {'user' => 'computer'}
    game.game_board[4] << {'user' =>'computer'}

    expect(game.did_user_win? 'computer').to eq true
    expect(game.did_user_win? 'human').to eq false
    
  end

   it 'should find a winning vertical row' do
    game = Games::ConnectFourGame.new
    
    game.game_board[1] << {'user' => 'human'}
    game.game_board[2] << {'user' => 'computer'}
    game.game_board[2] << {'user' => 'computer'}
    game.game_board[2] << {'user' => 'computer'}
    game.game_board[2] << {'user' => 'computer'}
    game.game_board[3] << {'user' => 'human'}
    game.game_board[3] << {'user' => 'computer'}
    game.game_board[4] << {'user' => 'human'}
   end

   it 'should find a winning horizontal up row' do
    game = Games::ConnectFourGame.new
    
    game.game_board[1] << {'user' => 'human'}
    game.game_board[2] << {'user' => 'computer'}
    game.game_board[2] << {'user' => 'human'}
    game.game_board[2] << {'user' => 'computer'}
    game.game_board[2] << {'user' => 'computer'}
    game.game_board[3] << {'user' => 'human'}
    game.game_board[3] << {'user' => 'computer'}
    game.game_board[3] << {'user' => 'human'}
    game.game_board[4] << {'user' => 'human'}
    game.game_board[4] << {'user' => 'human'}
    game.game_board[4] << {'user' => 'human'}
    game.game_board[4] << {'user' => 'human'}

    expect(game.did_user_win? 'computer').to eq false
    expect(game.did_user_win? 'human').to eq true
    
   end


   it 'should take slots when needing to block' do
    game = Games::ConnectFourGame.new
    
    game.game_board[1] << {'user' => 'human'}
    game.game_board[1] << {'user' => 'human'}
    game.game_board[2] << {'user' => 'computer'}
    game.game_board[2] << {'user' => 'human'}
    game.game_board[3] << {'user' => 'human'}
    game.game_board[3] << {'user' => 'human'}
    game.game_board[4] << {'user' => 'human'}
                            
 
    expect(game.game_board[4].count).to eq 1
    game.make_computers_move

     expect(game.game_board[4].count).to eq 2
    expect(game.did_user_win? 'computer').to eq false
    expect(game.did_user_win? 'human').to eq false
    
   end

   it 'should take slots when needing to win' do
    game = Games::ConnectFourGame.new
    
    game.game_board[1] << {'user' => 'human'}
    game.game_board[1] << {'user' => 'computer'}
    game.game_board[2] << {'user' => 'computer'}
    game.game_board[2] << {'user' => 'computer'}
    game.game_board[3] << {'user' => 'human'}
    game.game_board[3] << {'user' => 'computer'}
    game.game_board[4] << {'user' => 'human'}

    expect(game.game_board[4].count).to eq 1
    game.make_computers_move

    expect(game.game_board[4].count).to eq 2
    expect(game.did_user_win? 'computer').to eq true
    expect(game.did_user_win? 'human').to eq false
    
   end

   it 'should make a random move' do
    game = Games::ConnectFourGame.new
    game.make_computers_move

    expect(game.did_user_win? 'computer').to eq false
    expect(game.did_user_win? 'human').to eq false
    
   end

   it 'should take slots at beginning of streak when needing to win' do
    game = Games::ConnectFourGame.new

    game.game_board[0] << {'user' => 'human'}
    game.game_board[1] << {'user' => 'human'}
    game.game_board[1] << {'user' => 'computer'}
    game.game_board[2] << {'user' => 'computer'}
    game.game_board[2] << {'user' => 'computer'}
    game.game_board[3] << {'user' => 'human'}
    game.game_board[3] << {'user' => 'computer'}
    game.game_board[4] << {'user' => 'human'}
    game.game_board[4] << {'user' => 'human'}

    expect(game.game_board[0].count).to eq 1
    game.make_computers_move

    expect(game.game_board[0].count).to eq 2
    expect(game.did_user_win? 'computer').to eq true
    expect(game.did_user_win? 'human').to eq false
    
   end

   it 'should take slots when needing to block vertically' do
    game = Games::ConnectFourGame.new
    
    game.game_board[1] << {'user' => 'human'}
    game.game_board[1] << {'user' => 'human'}
    game.game_board[1] << {'user' => 'human'}
    game.game_board[2] << {'user' => 'computer'}
    game.game_board[2] << {'user' => 'human'}
    game.game_board[3] << {'user' => 'human'}
    game.game_board[3] << {'user' => 'computer'}
    game.game_board[4] << {'user' => 'human'}

    expect(game.game_board[1].count).to eq 3
    game.make_computers_move
    
    expect(game.game_board[1].count).to eq 4
    expect(game.did_user_win? 'computer').to eq false
    expect(game.did_user_win? 'human').to eq false
   end
end
