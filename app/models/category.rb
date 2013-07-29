class Category < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
  has_many :line_items, dependent: :destroy
end
