class Form < ActiveRecord::Base
  has_many :designs
  attr_accessible :mesh, :name, :icon, :front_mesh, :back_mesh
  
  mount_uploader :front_mesh, MeshUploader
  mount_uploader :back_mesh, MeshUploader
  mount_uploader :icon, IconUploader
  
end
