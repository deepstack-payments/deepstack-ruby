require 'json'

class PaymentInstrumentToken
    attr_accessor :payment_instrument_uuid

    def initialize(payment_instrument_uuid = nil)
        @payment_instrument_uuid = payment_instrument_uuid
        @type = "card"
    end

    def to_json
        {
            "type" => @type,
            "payment_instrument_uuid" => @payment_instrument_uuid
        }.to_json
    end
end