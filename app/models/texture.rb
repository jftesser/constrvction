class Texture < ActiveRecord::Base
  has_many :designs, :dependent => :destroy
  belongs_to :user
  
  attr_accessible :image, :name, :description
  
  mount_uploader :image, TextureUploader
  
=begin  
  has_attached_file :image, :styles => { :v512 =>"512x512#", :medium => "600x600>", :thumb => "100x100#" },
  :storage => :filesystem,
  :path => "public/textures/:id/:basename_:style.:extension",
  :url => "/textures/:id/:basename_:style.:extension"
=end
end
