class CreateConnectFourGames < ActiveRecord::Migration
  def change
    create_table :connect_four_games do |t|
      t.string :name
      t.string :column0, array: true, default: []
      t.string :column1, array: true, default: []
      t.string :column2, array: true, default: []
      t.string :column3, array: true, default: []
      t.string :column4, array: true, default: []
      t.string :column5, array: true, default: []
      t.string :column6, array: true, default: []
      t.datetime :save_time
    end
  end
end
