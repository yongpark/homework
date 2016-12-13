# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  session_token   :string           not null
#

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}
  after_initialize :ensure_session_token

  has_many :subs,
  primary_key: :id,
  foreign_key: :moderator_id,
  class_name: :Sub

  has_many :posts,
  primary_key: :id,
  foreign_key: :author_id,
  class_name: :Post


  attr_reader :password

  def is_password?(password)
    bc_obj = BCrypt::Password.new(password_digest)
    bc_obj.is_password?(password)
  end

  def self.find_by_credentials(username, password)
    @user = User.find_by(username: username)
    return if @user.nil?
    @user.is_password?(password) ? @user : nil
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(128)
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(128)
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end

end
