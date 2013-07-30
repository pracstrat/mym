require 'spec_helper'

describe ReceiptsController do
  describe "POST create" do
    let(:receipt) { Fabricate.build(:receipt) }
    let(:uploaded_file) { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/receipt1.jpg", "image/jpeg") }
    
    describe "with a scan as input" do
      it "creates a new Receipt" do
        uploaded_file.should_receive(:read) { "ABC" }
        Receipt.should_receive(:analyse).with("ABC") { receipt }
        receipt.should_receive(:save) { true }
        post :create, file: uploaded_file
        response.should redirect_to(edit_receipt_path(receipt))
      end
    end
  end
end
