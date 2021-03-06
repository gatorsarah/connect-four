Rails.application.routes.draw do

  match 'connect_four/new' => 'connect_four#new_game', :via => [:get], :as => :new_game
  match 'connect_four/play/' => 'connect_four#make_computers_move', :via => [:get], :as => :make_computers_move
  match 'connect_four/play/:column' => 'connect_four#users_move', :via => [:get, :post], :as => :users_move

  match 'connect_four/list' => 'connect_four#list_games', :via => [:get], :as => :list_games
  match 'connect_four/load/:game' => 'connect_four#load_game', :via => [:get], :as => :load_game
  match 'connect_four/save' => 'connect_four#save_game', :via => [:get], :as => :save_game
  
end
