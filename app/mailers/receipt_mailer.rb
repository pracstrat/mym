class ReceiptMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  default from: "from@example.com"
  
  def new_scan_notification(receipt)
    @receipt = receipt
    mail(to: "philip@51shepherd.com", subject: 'New Scanned Receipt Available')
  end
end
