require 'digest'
class User < ActiveRecord::Base
	attr_accessor :password
	validates :email, presence: true, uniqueness: true,
	format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/,message: 'The format of Email is invalid'}
	validates :username, presence: true, uniqueness: true

	validates_confirmation_of :password
	validates_length_of :password, :within => 4..50
	validates_presence_of :password, :if => :password_required?

	has_one :profile
	has_many :posts, -> { order('created_at DESC') },:dependent => :destroy
	has_many :replies, :through => :posts, :source => :comments

	before_save :encrypt_new_password


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


end
