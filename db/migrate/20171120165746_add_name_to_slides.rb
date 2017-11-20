class AddNameToSlides < ActiveRecord::Migration[5.0]
  def change
    add_column :slides, :name, :string
  end
end
