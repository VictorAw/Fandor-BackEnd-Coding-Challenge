class AddDefaultValueToDescriptionInFilm < ActiveRecord::Migration[5.0]
  def change
    change_column :films, :description, :text, default: "N/A"
  end
end
