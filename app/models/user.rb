require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password
  validates :email, presence: true, uniqueness: true, format: {
    with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/,
    message: 'The format of Email is invalid'
  }
  validates :username, presence: true, uniqueness: true

  validates :username, format: {
    with: /\A[a-zA-Z0-9]+\Z/,
    message: 'Username must contains alphabtic and numbers only'
  }

  validates_confirmation_of :password
  validates_length_of :password, :within => 4..50
  validates_presence_of :password, :if => :password_required?

  has_one :profile
  has_many :posts, -> { order('created_at DESC') },:dependent => :destroy
  has_many :replies, :through => :posts, :source => :comments

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
    class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :sent_messages, :class_name => 'Message',
    :foreign_key => 'sender_id'
  has_many :received_messages, :class_name => 'Message',
    :foreign_key => 'receiver_id'


  before_save :encrypt_new_password

  before_save { self.email = email.downcase }
  before_save { self.username = username.downcase }
  before_create :create_remember_token


  def self.authenticate(username, password)
    user = find_by_username(username)
    return user if user && user.authenticated?(password)
  end

  def authenticated?(password)
    self.hashed_password == encrypt(password)
  end

  def self.find(query)
    self.find_by_username(query) || super(query)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end


  protected
  def encrypt_new_password
    return if password.blank?
    self.hashed_password = encrypt(password)
  end

  def password_required?
    hashed_password.blank? || password.present?
  end

  def encrypt(string)
    Digest::SHA1.hexdigest(string)
  end

  private
  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end

end
