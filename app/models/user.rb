class User < ApplicationRecord
           acts_as_messageable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         has_many :orders

         def admin?
           is_admin
         end
         def mailboxer_email(object)
           email
         end
         has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "25x25#" }, :default_url => "/images/:style/missing.png"
         validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

         has_many :products
         has_many :favorites
         has_many :favorite_products, :through => :favorites, :source => :product
         def is_favorite_of?(product)
           favorite_products.include?(product)
         end
         has_many :posts
        ratyrate_rater
end
