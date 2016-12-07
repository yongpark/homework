class User < ApplicationRecord
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: { message: "Password can't be blank"}
  validate :password, length: {minimum: 6, allow_nil: true}
  before_validation :ensure_session_token


  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def self.ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def self.password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
end
