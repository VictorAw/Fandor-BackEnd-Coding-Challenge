class ChangeUrlSlugToUniqueInFilm < ActiveRecord::Migration[5.0]
  def change
    add_index :films, :url_slug, unique: true
  end
end
