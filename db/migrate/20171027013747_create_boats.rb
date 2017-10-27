class CreateBoats < ActiveRecord::Migration
  def change
    create_table :boats do |t|
      t.string :title
      t.text :description
      t.string :boat_dimensions
      t.string :place
      t.string :rating

      t.timestamps null: false
    end
  end
end
