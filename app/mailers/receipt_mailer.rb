class ReceiptMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def new_scan_notification(receipt)
    @receipt = receipt
    mail(to: "philip@51shepherd.com", subject: 'New Scanned Receipt Available')
  end
end
