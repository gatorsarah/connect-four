require 'spec_helper'

describe ColumnFull do

  it 'should initialize the exception with the message' do
    exception = ColumnFull.new 9
    expect(exception.message).to eq "Column 9 already has the max number of pieces"
  end
end
