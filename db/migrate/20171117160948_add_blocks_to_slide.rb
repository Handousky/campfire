class AddBlocksToSlide < ActiveRecord::Migration[5.0]
  def change
    add_column :slides, :block_access_from_left, :boolean, default: false
    add_column :slides, :block_access_from_right, :boolean, default: false
    add_column :slides, :block_access_from_up, :boolean, default: false
    add_column :slides, :block_access_from_down, :boolean, default: false
  end
end
