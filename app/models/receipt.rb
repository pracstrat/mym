require 'tesseract'
class Receipt < ActiveRecord::Base
  attr_accessor :ocr_error
  attr_accessor :from_scan
  validates :name, :purchase_date, presence: true
  has_many :line_items, dependent: :destroy
  
  after_create do |record|
    ReceiptMailer.new_scan_notification(record).deliver if record.from_scan
  end

  def self.analyse(io)
    receipt = Receipt.new(from_scan: true)
    begin
      text = ocr.text_for(io).strip
      lines = text.split(/\n/).reject{|line| line.blank?}.map(&:strip)

      receipt.name = store_name(lines)
      receipt.purchase_date = receipt_date(lines)
      receipt.line_items = receipt_line_items(lines)
    rescue =>ex
      receipt.ocr_error = ex.message
    end
    
    receipt
  end

  private
  def self.ocr
    @ocr||=Tesseract::Engine.new {|e|
      e.language  = :eng
      e.blacklist = '|'
    }
  end

  def self.store_name(lines)
    lines.first
  end

  def self.receipt_date(lines)
    lines.detect{|line|
      line=~/(\d{1,2}\/\d{1,2}\/\d{2,4})/
      return Date.strptime($1, "%m/%d/%Y") if $1
    }
  end

  def self.receipt_line_items(lines)
    lines.map{|line|
      line=~/(.*)\s+\$*(\d+\.\d+)/
      LineItem.new(name: $1.strip, amount: $2.strip) if $1&&$2
    }.compact
  end

end
