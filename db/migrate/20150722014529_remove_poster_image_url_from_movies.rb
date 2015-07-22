class RemovePosterImageUrlFromMovies < ActiveRecord::Migration
  
  def self.up
    remove_column :movies, :poster_image_url
  end

  def self.down
    add_column :movies, :poster_image_url
  end
end
