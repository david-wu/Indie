class User < ActiveRecord::Base
    include BCrypt
    validates :email, presence: true
    validates :email, uniqueness: true
    before_create :ensure_session_token
    has_many :events, class_name: "Event", foreign_key: "owner_id"

    def ensure_session_token
      self.session_token ||= SecureRandom.urlsafe_base64(16)
    end

    def password=(new_password)
      self.password_digest = BCrypt::Password.create(new_password)
    end

    def is_password?(password)
      bCrypt = BCrypt::Password.new(self.password_digest)
      return bCrypt.is_password?(password)
    end

    def reset_token()
      self.session_token = SecureRandom.urlsafe_base64(16)
      self.save
      return self.session_token
    end
end
