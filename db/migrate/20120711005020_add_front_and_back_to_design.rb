class AddFrontAndBackToDesign < ActiveRecord::Migration
  def change
    add_column :designs, :front_texture, :string
    add_column :designs, :back_texture, :string
    add_column :designs, :front_texture_x, :float
    add_column :designs, :front_texture_y, :float
    add_column :designs, :back_texture_x, :float
    add_column :designs, :back_texture_y, :float
  end
end
