require 'json'

class CardOptions
    attr_accessor :merchantDescriptor
    def initialize(descriptor = "")
        @merchantDescriptor = descriptor
    end
    
    def to_json
        {
            "merchant_descriptor" => @merchantDescriptor
        }.to_json
    end
end