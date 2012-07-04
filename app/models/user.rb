class User < ActiveRecord::Base
  has_many :designs
  has_many :textures
  
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :avatar, :avatar_file_name, :password, :password_confirmation, :remember_me, :invite_code
  attr_accessor :invite_code
  # attr_accessible :title, :body
  
  validates_each :invite_code, :on => :create do |record, attr, value|
      record.errors.add attr, "Please enter correct invite code" unless
        value && value == "MASHABLE34" || value == "KICKSTARTER56"
  end
  
  mount_uploader :avatar, AvatarUploader
  
end
