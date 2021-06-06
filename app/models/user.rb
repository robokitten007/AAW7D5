class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true
    validates :session_token, presence: true, uniqueness: true
    validates :passwor_digest, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}
    
    attr_reader :password
    after_initialize :ensure_session_token

    def self.find_by_credentials(username, password)

        @user = User.find_by(:username, username)
    
        return nil if !@user
        if @user && @user.is_password?(password)
        @user
        else nil 
        end 
    end 

    def password =(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end 

    def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(password)      
    end

    def generate_session_token
        self.sesson_token = SecureRandom.base64(64)
    end 

    def reset_session_token!
        self.session_token = SecureRandom.base64(64)
        self.save!
        self.sesson_token
    end 

    def ensure_session_token 
        self.sesson_token ||= SecureRandom.base64(64)
    end 

end
