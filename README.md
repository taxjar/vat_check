# VatCheck

Need to verify VAT identification numbers in Ruby? VatCheck makes it easy and simple:

```ruby
vat = VatCheck.new('GB333289454')
puts 'Legit' if vat.valid?
```

That's it. VatCheck first performs a regex validation. If it passes, it attempts to verify on VIES. [Sometimes it's up, sometimes it's down](http://ec.europa.eu/taxation_customs/vies/help.html). When it's down `valid?` gracefully falls back to regex.

## Getting Started

Install it via RubyGems in your terminal:

```
gem install vat_check
```

Or in your Gemfile:

```
gem 'vat_check'
```

## Basic Usage

```ruby
require 'vat_check'
vat = VatCheck.new('VATIN')
```

## Examples

VIES is available, the VAT is formatted correctly, and the VAT is registered to a business:

```ruby
vat = VatCheck.new('GB333289454')
vat.regex # true
vat.vies_available # true
vat.vies # true
vat.response # {:country_code=>"GB", :vat_number=>"333289454", :request_date=>#<Date: 2016-01-13 ((2457401j,0s,0n),+0s,2299161j)>, :valid=>true, :name=>"BRITISH BROADCASTING CORPORATION", :address=>"FAO ALEX FITZPATRICK\nBBC GROUP VAT MANAGER\nTHE LIGHT HOUSE (1ST FLOOR)\nMEDIA VILLAGE, 201 WOOD LANE\nLONDON\nW12 7TQ"}
vat.valid? # true
vat.exists? # true
```

VIES is available, the VAT ID is formatted correctly, but the VAT ID is not registered to a business:

```ruby
vat = VatCheck.new('GB999999999')
vat.regex # true
vat.vies_available # true
vat.vies # false
vat.response # {:country_code=>"GB", :vat_number=>"999999999", :request_date=>#<Date: 2016-01-13 ((2457401j,0s,0n),+0s,2299161j)>, :valid=>false, :name=>"---", :address=>"---"}
vat.valid? # false
vat.exists? # false
```

VAT is not formatted correctly:

```ruby
vat = VatCheck.new('XX123456789')
vat.regex # false
vat.vies # false
vat.vies_available # false
vat.response # {}
vat.valid? # false
vat.exists? # false
```

VAT is formatted correctly but VIES is unavailable:

```ruby
vat = VatCheck.new('GB333289454')
vat.regex # true
vat.vies_available # false
vat.vies # false
vat.response # {:error=>"Service unavailable"}
vat.valid? # true
vat.exists? # false
```

VAT is formatted correctly but VIES times out:

```ruby
vat = VatCheck.new('GB333289454')
vat.regex # true
vat.vies_available # false
vat.vies # false
vat.response # {:error=>"Service timed out"}
vat.valid? # true
vat.exists? # false
```
