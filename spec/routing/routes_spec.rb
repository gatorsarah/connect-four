require 'spec_helper'

describe "Routes", :type => :routing do

  it 'routes' do
    expect(:get => 'connect_four/new').to route_to(:controller => 'connect_four', :action => 'new_game')
    expect(:get => new_game_path).to route_to(:controller => 'connect_four', :action => 'new_game')
    expect(:get => 'connect_four/new').to be_routable

    expect(:get => 'connect_four/play/:column').to route_to(:controller => 'connect_four', :action => 'computers_move', 'column' => ':column')
    expect(:get => computers_move_path(6)).to route_to(:controller => 'connect_four', :action => 'computers_move', :column => '6')
    expect(:get => 'connect_four/play/:column').to be_routable

    expect(:post => 'connect_four/play/:column').to route_to(:controller => 'connect_four', :action => 'users_move', 'column' => ':column')
    expect(:post => computers_move_path(6)).to route_to(:controller => 'connect_four', :action => 'users_move', :column => '6')
    expect(:post => 'connect_four/play/:column').to be_routable
  end
end
