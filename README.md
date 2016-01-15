# TaxJar VAT Validation #

### Build and use ###

```
gem build taxjarvat.spec
gem install ./taxjarvat-0.0.1.gem

irb
require 'taxjarvat'
VatCheck.lookup('VATID')
VatCheck.valid?('VATID')
VatCheck.exists?('VATID')
```

### Example responses ###

Response for lookup if the service is available and the VAT ID is formatted correctly:
```
VatCheck.lookup('GB333289454')
{
  :valid=>true,
  :exists=>true,
  :response=>{
    :country_code=>"GB",
    :vat_number=>"333289454",
    :request_date=>#<Date: 2016-01-15 ((2457403j,0s,0n),+0s,2299161j)>,
    :valid=>true,
    :name=>"BRITISH BROADCASTING CORPORATION",
    :address=>"FAO ALEX FITZPATRICK\nBBC GROUP VAT MANAGER\nTHE LIGHT HOUSE (1ST FLOOR)\nMEDIA VILLAGE, 201 WOOD LANE\nLONDON\nW12 7TQ"
  }
}
```


Response for lookup if the service is available, the VAT ID is formatted correctly, but the VAT ID is not registered to a business:
```
VatCheck.lookup('GB999999999')
{
  :valid=>true,
  :exists=>false,
  :response=>{
    :country_code=>"GB",
    :vat_number=>"999999999",
    :request_date=>#<Date: 2016-01-15 ((2457403j,0s,0n),+0s,2299161j)>,
    :valid=>false,
    :name=>"---",
    :address=>"---"
  }
}
```


Response for lookup if the VAT ID is not formatted correctly:
```
VatCheck.lookup('XX999999999')
{
  :valid=>false,
  :exists=>false
}
```


Response for lookup if the VAT ID is formatted correctly but the service is unavailable:
```
VatCheck.lookup('GB333289454')
{
  :valid=>true,
  :exists=>false,
  :response=>{
     :error=>'Service unavailable'
  }
}
```


Response for lookup if VAT ID is formatted correctly but the service timed out:
```
VatCheck.lookup('GB333289454')
{
  :valid=>true,
  :exists=>false,
  :response=>{
     :error=>'Service timed out'
  }
}
```

VatCheck.exists?('VATID') will return true of VAT lookup service returns a valid response.

VatCheck.valid?('VATID') will return true or false if the the ID passes the VatCheck::Format validation.