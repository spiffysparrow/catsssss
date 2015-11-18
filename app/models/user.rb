class User < ActiveRecord::Base
  attr_reader :password

  validates :user_name, :password_digest, :session_token, presence: true
  after_initialize :reset_session_token!

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    session_token = nil
    session_token = User.generate_session_token
  end

  def ensure_session_token
    session_token ||= User.generate_session_token
  end

  def password=(password)
    @password = password
    password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    password_digest = BCrypt::Password.new(password_digest)
    password_digest.is_password?(password)
  end

  def find_by_credentials(user_name, password)
    @user ||= User.find_by(user_name: user_name)
    if @user.password_digest.is_password?(password)
      return @user
    end
    nil
  end
end
