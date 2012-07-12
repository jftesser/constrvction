class Design < ActiveRecord::Base
  belongs_to :form
  belongs_to :texture
  belongs_to :user
  attr_accessible :form_id, :texture_id, :image_data, :title, :description, :preview, :front_texture, :back_texture, :front_texture_x, :front_texture_y, :back_texture_x, :back_texture_y, :front_texture_data, :back_texture_data, :filter_name, :filter_params
  
  attr_accessor :image_data, :front_texture_data, :back_texture_data
  
  mount_uploader :preview, ImageUploader
  mount_uploader :front_texture, BasicUploader
  mount_uploader :back_texture, BasicUploader
  
=begin
  has_attached_file :preview, :styles => { :thumb => "200x200>", :thumb => "100x100#" },
  :storage => :filesystem,
  :path => "public/designs/:id/:design_preview_:id.:extension",
  :url => "/designs/:id/:basename_:id.:extension"
=end
end
