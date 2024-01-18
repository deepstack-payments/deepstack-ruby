## DeepStack Ruby SDK ##
____

### General Flow ####

1. Create DeepStackClient object
2. Create Request object (Request will require other Deepstack objects as parameters but we'll discuss those below)
3. Send request using *RequestObject*.sent(*DeepStackClient*)
4. Response will be returned as Map (Error is raised if response status code is not 200)

### Creating DeepStackClient ###

Creating a `DeepStackClient` requires 4 paramters : username, password, secretKey, and isProduction boolean. The boolean is defaulted to `true` meaning it will go into a live server so specify `false` as the fourth parameter if you want to hit the DeepStack nightly environment, make sure to use a 4th parameter.

``` Ruby

client = DeepStackClient.new(username, password, secretKey, isProduction)

```

### Creating a PaymentInstrument (token) ###

``` Ruby

card = PaymentInstrumentCard.new(card_name, card_number, card_expiration, card_billing_address, card_billing_zipcode, card_cvv)
instrument = PaymentInstrumentCreate.new(merchant_uuid, card)
request = PaymentInstrumentCreateRequest.new(instrument)

response = request.send(client)

token = response["response"]["payment_instrument_uuid"]

```

### Authorizing transaction ###

```Ruby

paymenToken = PaymentInstrumentToken.new(token)
authorization = Authorization.new(merchant_uuid)
authorization.paymentInstrument = paymentToken
# Amount: Integer representing the total number of cents. 9.99 => 999
authorization.amount = amount 
# ReferenceNumber: Anything to identify the transaction in your system
authorization.referenceNumber = anyValueUsedToIdentifyTransaction
# Capture: Set to false if you just want to authorize the CC and amount it defaults to true if omitted
# authorization.capture = false 


```

To set card options

```Ruby

cardOptions = CardOptions.new()
cardOptions.merchantDescriptor = name
authorization.cardOptions = cardOptions

```

Setting custom fields (ShippingContact)

``` Ruby

contact = ShippingContact.new
contact.contactName = name
contact.contactAddress = address
contact.contactCity = city
contact.contactState = state
contact.contactPostalCode = postalCode
contact.contactPhone = phone
contact.contactEmail = email

customFields = {
    "shipping_contact" => JSON.parse(contact.to_json),
    "source_reference" => source reference
}

authorization.customFields = customFields

```
Now create request and send it

```Ruby

request = AuthorizationRequest.new(authorization)
response = request.send(client)

txnUUID = response["response"]["transaction_uuid"]
responseCodeDesc = response["response"]["response_code_description"]
responseCode = response["response"]["response_code"]

```