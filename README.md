# TaxJar VAT Validation #

### Build and use ###

```
gem build taxjarvat.spec
gem install ./taxjarvat-0.0.1.gem

irb
require 'taxjarvat'
TaxJarVat.lookup('VATID')
TaxJarVat.valid?('VATID')
TaxJarVat.exists?('VATID')
```

### Example responses ###

Response for lookup if the service is available and the VAT ID is formatted correctly:
```
TaxJarVat.lookup('GB333289454')
{
  :valid=>true, 
  :exists=>{
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
TaxJarVat.lookup('GB999999999')
{
  :valid=>true, 
  :exists=>false 
}
```


Response for lookup if the VAT ID is not formatted correctly:
```
TaxJarVat.lookup('XX999999999')
{
  :valid=>false,
  :exists=>false
}
```


Response for lookup if the VAT ID is formatted correctly but the service is unavailable:
```
TaxJarVat.lookup('GB333289454')
{
  :valid=>true,
  :exists=>'Service unavailable'
}
```


Response for lookup if VAT ID is formatted correctly but the service timed out:
```
TaxJarVat.lookup('GB333289454')
{
  :valid=>true,
  :exists=>'Service timed out'
}
```

TaxJarVat.exists?('VATID') will return true, false, or an error message if VAT lookup service returns a valid flag.

TaxJarVat.valid?('VATID') will return true or false if the the ID passes the TaxJarVat::Format validation.