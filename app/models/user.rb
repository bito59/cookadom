class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #has_many :recipes, dependent: :destroy
  has_one :cook, dependent: :destroy

  has_attached_file :image, styles: { thumb: "200x200#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
         
end
