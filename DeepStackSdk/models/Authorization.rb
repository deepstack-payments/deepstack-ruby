require 'json'
require './DeepStackSdk/models/CardOptions'

class Authorization
    attr_accessor :amount, :paymentInstrument, :referenceNumber, :cardOptions, :achOptions, :customFields, :capture, :merchantUUID

    def initialize(merchant_uuid, capture = true)
        @merchantUUID = merchant_uuid
        @capture = capture
    end

    def to_json
        {
            "amount" => @amount,
            "capture" => @capture,
            "payment_instrument" => JSON.parse(@paymentInstrument.to_json),
            "card_options" => JSON.parse(@cardOptions.to_json) || JSON.parse(CardOptions.new().to_json),
            "merchant_uuid" => @merchantUUID || "",
            "reference_number" => @referenceNumber || "",
            "custom_fields" => @customFields || {"source_reference" => ""}
        }.to_json
    end
end