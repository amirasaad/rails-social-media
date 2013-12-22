class SiteController < ApplicationController
	include ActionController::Live
	def home
		100.times {
			response.stream.write "hello world\n"
		}
		response.stream.close

	end

	def about
	end

	def contact
	end

	def help
	end

end
