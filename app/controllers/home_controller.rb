class HomeController < ApplicationController
	include HomeHelper

	def index
		# quote
		response = get_quote
		if response.code == 200
			# FIXME - not working if quoteText contains double quoted string
			begin
				JSON.parse(response.body)
			rescue
				@quote = fallback_quote
			else
				@quote = JSON.parse(response.body)
			end
		else
			@quote = fallback_quote
		end
	end

	def search
    byebug
  end
end
