class AddFilterToDesign < ActiveRecord::Migration
  def change
    add_column :designs, :filter_name, :string
    add_column :designs, :filter_params, :string
  end
end
