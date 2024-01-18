require 'json'

class ShippingContact

    attr_accessor :contactName, :contactAddress, :contactCity, :contactState, :contactPostalCode, :contactPhone, :contactEmail

    def to_json
        {
            "contact_name" => @contactName || "",
            "contact_address" => @contactAddress,
            "contact_city" => @contactCity,
            "contact_state" => @contactState,
            "contact_postal_code" => @contactPostalCode,
            "contact_phone" => @contactPhone || "",
            "contact_email" => @contactEmail || ""
        }.to_json
    end

end