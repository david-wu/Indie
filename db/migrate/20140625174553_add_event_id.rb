class AddEventId < ActiveRecord::Migration
  def change
  	add_column :perks, :event_id, :integer
  	add_column :perks, :img_src, :string
  end
end
