require 'spec_helper'

describe LineItem do

  describe "validation" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:amount) }
  end

  describe "associations" do
    it { should belong_to(:receipt) }
    it { should belong_to(:category) }
  end
end
