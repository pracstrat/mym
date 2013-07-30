require "spec_helper"

describe ReceiptMailer do
  describe "new_scan_notification" do
    let(:receipt) { mock_model(Receipt) }
    let(:email) { ReceiptMailer.new_scan_notification(receipt).deliver }

    # it { email.from.should == "from@example.com" }
    # it { email.to.should == "philip@51shepherd.com" }
    # it { email.subject.should == "New Scanned Receipt Available" }
    # it { email.body.to_s.should match(/You uploaded a new receipt. This is what is it looks like:/) }
  end
end
