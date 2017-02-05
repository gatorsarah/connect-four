class ConnectFourGame < ActiveRecord::Base

  validates :save_time, presence: true
  validates_uniqueness_of :save_time

end
