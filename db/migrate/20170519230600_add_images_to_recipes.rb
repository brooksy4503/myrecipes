class AddImagesToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :image, :string
  end
end
