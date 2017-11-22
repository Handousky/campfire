class AddSoundToSlides < ActiveRecord::Migration[5.0]
  def change
    add_column :slides, :sound, :string, default: ""
  end
end
