if @receipt.valid?
  json.name @receipt.name
  json.date @receipt.purchase_date
  json.line_items @receipt.line_items, :name, :amount
  json.status 'success'
else
  json.status 'failure'
end