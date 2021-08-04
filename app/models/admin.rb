class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  with_options presence: true do
    validates :email
    validates :name
    validates :phone_number
  end
  
  validates :phone_number, format: {with: /\A[0-9]{10,11}\z/}
  attachment :admin_image
  
end
