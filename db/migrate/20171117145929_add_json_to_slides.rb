class AddJsonToSlides < ActiveRecord::Migration[5.0]
  def change
    add_column :slides, :json, :text
  end
end
