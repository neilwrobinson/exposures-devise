class AddPhotocwToPhotoscw < ActiveRecord::Migration[7.0]
  def change
    add_column :photoscws, :image, :string
  end
end
