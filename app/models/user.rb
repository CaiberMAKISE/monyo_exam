class User < ApplicationRecord
    before_destroy :admin_destroy_check
    before_update :admin_edit_check
    validates :name, presence: true, length: { maximum: 30 }
    validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    validates :password, presence: true, length: { minimum: 6 }
    before_validation { email.downcase! }
    has_secure_password
    has_many :tasks, dependent: :destroy
    private
    def admin_destroy_check
        if  admin == true
            user_count = User.where(admin: true).count
            throw(:abort) if user_count <= 1
        end
    end
    def admin_edit_check
        if  admin == false
            user_count = User.where(admin: true).count
            throw(:abort) if user_count <= 1
        end
    end
end
