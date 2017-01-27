require 'spec_helper'

describe Slot do

  it 'should initialize Slot with the correct values' do
    slot = Slot.new('human')

    expect(slot.user).to eq 'human'
  end
end
