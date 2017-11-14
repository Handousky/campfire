class CreateStoryCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :story_categories do |t|
      t.references :story, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
