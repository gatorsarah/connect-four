require 'spec_helper'

describe "Routes", :type => :routing do

  it 'routes' do
    expect(:get => 'connect_four/new').to route_to(:controller => 'connect_four', :action => 'new_game')
    expect(:get => new_game_path).to route_to(:controller => 'connect_four', :action => 'new_game')
    expect(:get => 'connect_four/new').to be_routable

    expect(:get => 'connect_four/play/').to route_to(:controller => 'connect_four', :action => 'make_computers_move')
    expect(:get => make_computers_move_path).to route_to(:controller => 'connect_four', :action => 'make_computers_move')
    expect(:get => 'connect_four/play/').to be_routable

    expect(:get => 'connect_four/play/:column').to route_to(:controller => 'connect_four', :action => 'users_move', 'column' => ':column')
    expect(:get => users_move_path('choose')).to route_to(:controller => 'connect_four', :action => 'users_move', :column => 'choose')
    expect(:get => 'connect_four/play/:column').to be_routable

    expect(:post => 'connect_four/play/:column').to route_to(:controller => 'connect_four', :action => 'users_move', 'column' => ':column')
    expect(:post => users_move_path(6)).to route_to(:controller => 'connect_four', :action => 'users_move', :column => '6')
    expect(:post => 'connect_four/play/:column').to be_routable
  end
end
