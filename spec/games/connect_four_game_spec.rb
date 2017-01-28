require 'spec_helper'

describe ConnectFourGame do

  it 'should initialize a new game board' do

    game = ConnectFourGame.new

  end

  it 'should take a new slot' do
    game = ConnectFourGame.new
    game.record_users_move(3)
   end
  
end
