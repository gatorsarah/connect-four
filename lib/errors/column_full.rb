class ColumnFull < StandardError
  attr_accessor :message

  def initialize(column)
    @message = "Column #{column} already has the max number of pieces"
  end
end
