require 'spec_helper'

describe Slot do

  it 'should initialize Slot with the correct values' do
    slot = Slot.new(3, 4, 'human')

    expect(slot.row).to eq 3
    expect(slot.column).to eq 4
    expect(slot.user).to eq 'human'
  end
end
