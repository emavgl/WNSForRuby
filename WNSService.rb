require 'net/http'
require 'rubygems'
require 'json'

def getMyAccessToken(sid, secret)
	@body = "grant_type=client_credentials&client_id=#{sid}&client_secret=#{secret}&scope=notify.windows.com"

	uri = URI("https://login.live.com/accesstoken.srf")
	https = Net::HTTP.new(uri.host, uri.port)
	https.use_ssl = true

	request = Net::HTTP::Post.new(uri.path)

	request.content_type = 'application/x-www-form-urlencoded'
	request.body = @body

	response = https.request(request)

	parsed = JSON.parse(response.body())
	return parsed['access_token']
end
