require 'json'
require './DeepStackSdk/models/PaymentInstrumentCard'
require './DeepStackSdk/models/PaymentInstrumentToken'

class PaymentInstrumentCreate

    attr_accessor :MerchantUUID, :PaymentInstrument
    def initialize(merchantUUID = nil, paymentInstrument = nil)
        @MerchantUUID = merchantUUID
        @PaymentInstrument = paymentInstrument
    end

    def to_json
        {
            "merchant_uuid" => @MerchantUUID,
            "payment_instrument" => JSON.parse(@PaymentInstrument.to_json)
        }.to_json
    end
end