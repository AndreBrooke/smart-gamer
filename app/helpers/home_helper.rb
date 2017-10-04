module HomeHelper
	def get_quote
		RestClient.get("http://api.forismatic.com/api/1.0/?method=getQuote&key=&format=json&lang=en")
	end

	def fallback_quote
		{"quoteText"=>"Play Smart, Not Hard.", "quoteAuthor"=>"Lee Siew Ching", "senderName"=>"", "senderLink"=>"", "quoteLink"=>""}
	end
end
