class Post < ActiveRecord::Base
	validates_presence_of :body

	belongs_to :user
	has_many :comments, :dependent => :destroy


	scope :where_body, lambda { |term| where("posts.body LIKE ?", "%#{term}%") }

	def owned_by?(owner)
		return false unless owner.is_a?(User)
		user == owner
	end

	def latest_comments
		return comments.order('created_at DESC').take(2)
	end

end
