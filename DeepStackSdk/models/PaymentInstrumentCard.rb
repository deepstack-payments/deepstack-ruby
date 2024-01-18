require 'json'

class PaymentInstrumentCard
    attr_accessor :card_name, :card_number, :card_expiration, :card_billing_address, :card_billing_zipcode, :card_cvv
    def initialize(card_name = nil, card_number = nil, card_expiration = nil, card_billing_address = nil, card_billing_zipcode = nil, card_cvv = nil)
        @card_name = card_name
        @card_number = card_number
        @card_expiration = card_expiration
        @card_billing_address = card_billing_address
        @card_billing_zipcode = card_billing_zipcode
        @card_cvv = card_cvv
        @type = "card"
    end
    def to_json
        {"card_name" => @card_name,
        "card_number" => @card_number,
        "card_expiration" => @card_expiration,
        "card_billing_address" => @card_billing_address,
        "card_billing_zipcode" => @card_billing_zipcode,
        "card_cvv" => @card_cvv,
        "type" => @type
        }.to_json
    end
end