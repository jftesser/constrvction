class MoveAvatarToCarrierwave < ActiveRecord::Migration
  def up
    remove_column :users, :avatar_file_name
    remove_column :users, :avatar_content_type
    remove_column :users, :avatar_file_size
    remove_column :users, :avatar_updated_at
    
    add_column :users, :avatar, :string
  end

  def down
    remove_column :users, :avatar
    
    add_column :users, :avatar_file_name, :string
    add_column :users, :avatar_content_type, :string
    add_column :users, :avatar_file_size, :integer
    add_column :users, :avatar_updated_at, :datetime
  end
end
