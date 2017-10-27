class AddBoatIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :boat_id, :integer
  end
end
