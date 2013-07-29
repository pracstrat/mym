class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.string :name
      t.decimal :amount, precision: 10, scale: 2
      t.boolean :advance
      t.references :category
      t.references :receipt
    end
    add_foreign_key(:line_items, :categories)
    add_foreign_key(:line_items, :receipts)
  end
end
