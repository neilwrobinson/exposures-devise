class CreatePhotoscws < ActiveRecord::Migration[7.0]
  def change
    create_table :photoscws do |t|
      t.date :date
      t.string :title
      t.string :location
      t.string :description

      t.timestamps
    end
  end
end
