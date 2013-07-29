require 'spec_helper'

describe Receipt do
  describe "Validation" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:purchase_date) }
  end

  describe "associations" do
    it { should have_many(:line_items) }
  end

  describe "OCR process" do
    it "analyse image" do
      path = fixture_file_path("receipt1.jpg")
      receipt = Receipt.analyse(File.read(path))
      expect(receipt.name).to eq("1 LOU MALNATI’S PIZZERIA")
      expect(receipt.purchase_date.strftime("%m/%d/%Y")).to eq("12/31/2012")
      expect(receipt.line_items.size).to eq(6)
      # expect(receipt.line_items.map(&:amount)).to eq([13.75, 15.60, 29.35, 3.01, 32.36])
      # expect(receipt.line_items.map(&:name)).to eq(['Medium Pan Cheese', 'ayedium Pan Cheese', 'e Sub TotaT', 'Tax', '3 03 Total', 'Paid'])
    end

    it "amount without $" do
      path = fixture_file_path("receipt3.jpg")
      receipt = Receipt.analyse(File.read(path))
      expect(receipt.name).to match(/andu1ches and Salads/)
      expect(receipt.purchase_date.strftime("%m/%d/%Y")).to eq("07/13/2013")
      expect(receipt.line_items.size).to eq(6)
      # expect(receipt.line_items.map(&:amount)).to eq([5.00, 5.00, 10.00, 0.88, 10.88, 10.38])
    end

    it "bad image" do
      path = fixture_file_path("receipt2.jpg")
      receipt = Receipt.analyse(File.read(path))
      expect(receipt.purchase_date).to be_nil
      expect(receipt.valid?).to be_false
    end
  end
end
