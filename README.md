# TaxJar VAT Validation #

### Build and use ###

```
gem build vat_check.gemspec
gem install ./vat_check-#.#.#.gem

irb
require 'vat_check'
var = VatCheck.new('VATID')
```

### Example responses ###

VIES is available, the VAT is formatted correctly, and the VAT is registered to a business
```
vat = VatCheck.new('GB333289454')
vat.regex # true
vat.vies_available # true
vat.vies # true
vat.response # {:country_code=>"GB", :vat_number=>"333289454", :request_date=>#<Date: 2016-01-13 ((2457401j,0s,0n),+0s,2299161j)>, :valid=>true, :name=>"BRITISH BROADCASTING CORPORATION", :address=>"FAO ALEX FITZPATRICK\nBBC GROUP VAT MANAGER\nTHE LIGHT HOUSE (1ST FLOOR)\nMEDIA VILLAGE, 201 WOOD LANE\nLONDON\nW12 7TQ"}
vat.valid? # true
vat.exists? # true
```


VIES is available, the VAT ID is formatted correctly, but the VAT ID is not registered to a business:
```
vat = VatCheck.new('GB999999999')
vat.regex # true
vat.vies_available # true
vat.vies # false
vat.response # {:country_code=>"GB", :vat_number=>"999999999", :request_date=>#<Date: 2016-01-13 ((2457401j,0s,0n),+0s,2299161j)>, :valid=>false, :name=>"---", :address=>"---"}
vat.valid? # false
vat.exists? # false
```


VAT is not formatted correctly:
```
vat = VatCheck.new('XX123456789')
vat.regex # false
vat.vies # false
vat.vies_available # false
vat.response # {}
vat.valid? # false
vat.exists? # false

```


VAT is formatted correctly but VIES is unavailable:
```
vat = VatCheck.new('GB333289454')
vat.regex # true
vat.vies_available # false
vat.vies # false
vat.response # {:error=>"Service unavailable"}
vat.valid? # true
vat.exists? # false
```


VAT is formatted correctly but VIES times out:
```
vat = VatCheck.new('GB333289454')
vat.regex # true
vat.vies_available # false
vat.vies # false
vat.response # {:error=>"Service timed out"}
vat.valid? # true
vat.exists? # false
```
