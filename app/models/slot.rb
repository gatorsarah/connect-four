 class Slot
    attr_accessor :row, :column, :user

    def initialize(row, column, user)
      @row = row
      @column = column
      @user = user
  end
end
