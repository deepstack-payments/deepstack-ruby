require 'base64'
require 'openssl'
require 'uri'
require 'net/http'
require 'net/https'


require './DeepStackSdk/models/PaymentInstrumentCard'
require './DeepStackSdk/models/PaymentInstrumentCreate'
require './DeepStackSdk/requests/PaymentInstrumentCreateRequest'
require './DeepStackSdk/models/Authorization'
require './DeepStackSdk/models/CardOptions'
require './DeepStackSdk/models/ShippingContact'
require './DeepStackSdk/requests/AuthorizationRequest'

class DeepStackClient

    attr_accessor :baseAddress, :isProduction
    def initialize(username, password, secretKey, isProduction = false)
        @username = username
        @password = password
        @secretKey = secretKey
        @baseAddress = @isProduction ? "https://api2.deepstack.io" : "https://api.deepstacknightly.io"
        @isProduction = isProduction
    end

    def Send(path, method, data)
        # createHash(data.to_json)
        uri = URI(@baseAddress + path)
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true
        # https.verify_mode = OpenSSL::SSL::VERIFY_NONE

        req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json',
                                                            'Accept' => 'application/json',
                                                            'Endpoint-UUID' => @username,
                                                            'Content-Hash' => createHash(data)})
        req.basic_auth(@username, @password)
        req.body = data.to_json
        response = https.request(req)
        # puts "Response #{response.code} #{response.message}: #{response.body}"
        
        if response.code != "200"
            raise "Bad request... code:  " + response.code + " message: " + response.message
        end
        
        return JSON.parse(response.body)
    end

    # Unused since Ruby has built in auth creation
    def getAuthenticationHeader
        toEncode = @username + ":" + @password
        "Basic " + Base64.encode64(toEncode)
    end
    
    def createHash(data)
        hash = Base64.strict_encode64(OpenSSL::HMAC.digest('sha256', [@secretKey].pack('H*'), data.to_json))
        return hash
    end
    # Unused right now
    def hex2string(hex)
        return Base64.decode64([hex].pack('H*'))
    end
end