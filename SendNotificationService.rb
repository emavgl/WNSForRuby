require 'net/http'
require 'rubygems'
require 'uri'
require_relative 'WNSService.rb'

class SendNotificationService

  def initialize(sid, secret)
    @myToken = getMyAccessToken(sid, secret)
  end

  def sendNotificationToUser(userSecretURI, title, body)
    xml = createToastXML(title, body)

    @myHeader = {
      "Content-Length" => xml.length.to_s,
      "Content-Type" => "text/xml",
      "X-WNS-Type" => "wns/toast",
      "X-WNS-RequestForStatus" => "true",
      "Authorization" => "Bearer " + @myToken
    }

    @path = URI.parse(userSecretURI)
    @data = xml

    uri = URI.parse(userSecretURI)
    @https = Net::HTTP.new(uri.host, uri.port)
    @https.use_ssl = true

    response = @https.post(@path, @data, @myHeader)

  end

  private

  def createToastXML(title, body)
     xml = "<?xml version='1.0'	encoding='utf-8'?><toast><visual><binding template='ToastText02'><text id='1'>" + title +"</text><text id='2'>" + body +"</text></binding></visual></toast>"
     return xml;
  end


end
