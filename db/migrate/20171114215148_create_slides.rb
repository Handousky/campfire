class CreateSlides < ActiveRecord::Migration[5.0]
  def change
    create_table :slides do |t|
      t.text :narration
      t.integer :x_axis
      t.integer :y_axis
      t.references :story, foreign_key: true

      t.timestamps
    end
  end
end
