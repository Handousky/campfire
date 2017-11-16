class AddPublishedToStories < ActiveRecord::Migration[5.0]
  def change
    add_column :stories, :published, :boolean, default: false
  end
end
