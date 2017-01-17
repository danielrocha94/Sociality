class AddPositiveToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :positive, :boolean, default: true
  end
end
