require "spec_helper"

describe ApplicationHelper do
  describe "#as_dollar" do
    it "formats as dollar" do
      helper.as_dollar(9.899).should == "$ 9.90"
    end
  end
end