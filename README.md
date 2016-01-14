# TaxJar VAT Validation #

### Build and use ###

```
gem build taxjarvat.spec
gem install ./taxjarvat-0.0.1.gem

irb
require 'taxjarvat'
TaxJarVat.validate('VATID')
```

### Example responses ###

Response if the service is available and the VAT ID is formatted correctly
```
TaxJarVat.validate('GB333289454')
{
  :format_valid=>true, 
  :country_code=>"GB", 
  :vat_number=>"333289454", 
  :request_date=>#<Date: 2016-01-14 ((2457402j,0s,0n),+0s,2299161j)>, 
  :valid=>true, 
  :name=>"BRITISH BROADCASTING CORPORATION", 
  :address=>"FAO ALEX FITZPATRICK\nBBC GROUP VAT MANAGER\nTHE LIGHT HOUSE (1ST FLOOR)\nMEDIA VILLAGE, 201 WOOD LANE\nLONDON\nW12 7TQ", 
  :@xmlns=>"urn:ec.europa.eu:taxud:vies:services:checkVat:types"
}
```

Response if the service is available, the VAT ID is formatted correctly, but the VAT ID is not registered to a business
```
TaxJarVat.validate('GB999999999')
{
  :format_valid=>true, 
  :country_code=>"GB", 
  :vat_number=>"999999999", 
  :request_date=>#<Date: 2016-01-14 ((2457402j,0s,0n),+0s,2299161j)>, 
  :valid=>false, :name=>"---", 
  :address=>"---", 
  :@xmlns=>"urn:ec.europa.eu:taxud:vies:services:checkVat:types"
}
```

Response if the VAT ID is not formatted correctly
```
TaxJarVat.validate('XX999999999')
{
  :format_valid=>false
}
```

Response if the VAT ID is formatted correctly but the service is unavailable
```
TaxJarVat.validate('GB333289454')
{
  :format_valid=>true,
  :valid=>'Service unavailable'
}
```

Response if VAT ID is formatted correctly but the service timed out
```
TaxJarVat.validate('GB333289454')
{
  :format_valid=>true,
  :valid=>'Service timed out'
}
```