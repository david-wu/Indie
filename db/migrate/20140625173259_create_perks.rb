class CreatePerks < ActiveRecord::Migration
  def change
    create_table :perks do |t|
      t.string :title
      t.integer :cost
      t.string :currency
      t.text :description
      t.integer :claimed
      t.integer :available
      t.string :delivery_date

      t.timestamps
    end
  end
end
