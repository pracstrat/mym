require "spec_helper"

describe ReceiptMailer do
  describe "new_scan_notification" do
    let(:receipt) { Fabricate.build(:receipt) }
    let(:email) { ReceiptMailer.new_scan_notification(receipt).deliver }
    
    it "should send an email" do
      email.from.should == ["from@example.com"]
      email.to.should == ["philip@51shepherd.com"]
      email.subject.should == "New Scanned Receipt Available"
      email.body.to_s.should match(/You uploaded a new receipt. This is what is it looks like:/)
    end
  end
end
