class LineItem < ActiveRecord::Base
  validates :name, :amount, presence: true
  belongs_to :receipt
  belongs_to :category
end
