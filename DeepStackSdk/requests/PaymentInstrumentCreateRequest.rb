require 'json'
require "./DeepStackSdk/DeepStackClient"
require "./DeepStackSdk/models/PaymentInstrumentCreate"

class PaymentInstrumentCreateRequest

    attr_accessor :Data
    def initialize(data = nil)
        @Path = "/CometAPI/PaymentInstrument/create"
        @Method = "POST"
        @Data = data
    end

    def send(client)
        response = client.Send(@Path, @Method, @Data)
    end

    def to_json
        {
            "Path" => @Path,
            "Method" => @Method,
            "Data" => JSON.parse(@Data.to_json)
        }.to_json
    end

end