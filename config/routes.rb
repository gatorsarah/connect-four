Rails.application.routes.draw do

  match 'connect_four/new' => 'connect_four#new_game', :via => [:get], :as => :new_game
  match 'connect_four/play/' => 'connect_four#make_computers_move', :via => [:get], :as => :make_computers_move
  match 'connect_four/play/:column' => 'connect_four#users_move', :via => [:post], :as => :users_move
  
end
