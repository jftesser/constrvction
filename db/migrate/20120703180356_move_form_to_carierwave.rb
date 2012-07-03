class MoveFormToCarierwave < ActiveRecord::Migration
  def up

    add_column :forms, :icon, :string
    add_column :forms, :front_mesh, :string
    add_column :forms, :back_mesh, :string
    
    remove_column :forms, :front_mesh_file_name
    remove_column :forms, :front_mesh_content_type
    remove_column :forms, :front_mesh_file_size
    remove_column :forms, :front_mesh_updated_at
    
    remove_column :forms, :back_mesh_file_name
    remove_column :forms, :back_mesh_content_type
    remove_column :forms, :back_mesh_file_size
    remove_column :forms, :back_mesh_updated_at
    
    remove_column :forms, :image_file_name
    remove_column :forms, :image_content_type
    remove_column :forms, :image_file_size
    remove_column :forms, :image_updated_at
    
  end

  def down
    remove_column :forms, :icon
    remove_column :forms, :front_mesh
    remove_column :forms, :back_mesh
    
    add_column :forms, :front_mesh_file_name, :string
    add_column :forms, :front_mesh_content_type, :string
    add_column :forms, :front_mesh_file_size, :integer
    add_column :forms, :front_mesh_updated_at, :datetime
    
    add_column :forms, :back_mesh_file_name, :string
    add_column :forms, :back_mesh_content_type, :string
    add_column :forms, :back_mesh_file_size, :integer
    add_column :forms, :back_mesh_updated_at, :datetime
    
    add_column :forms, :image_file_name, :string
    add_column :forms, :image_content_type, :string
    add_column :forms, :image_file_size, :integer
    add_column :forms, :image_updated_at, :datetime
    
  end
end
