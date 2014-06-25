class AddEventId < ActiveRecord::Migration
  def change
  	add_column :perks, :event_id, :integer
  end
end
