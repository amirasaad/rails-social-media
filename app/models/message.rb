class Message < ActiveRecord::Base
	belongs_to :sender, class_name: "User"
	belongs_to :reciver, class_name: "User"

	validates_presence_of :content
end
