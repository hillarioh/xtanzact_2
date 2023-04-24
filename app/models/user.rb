class User < ApplicationRecord
    has_secure_password    
    has_many :accounts, :dependent => :destroy

    validates :first_name, :last_name, :tel_no, :email_address, presence: true
    validates :email_address, :tel_no, uniqueness: true
end
