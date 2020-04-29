Gem::Specification.new do |s|
  s.name          = 'vat_check'
  s.version       = '0.0.5'
  s.date          = '2016-01-11'
  s.licenses      = ['MIT']
  s.summary       = 'Validate VAT IDs'
  s.description   = 'A gem by TaxJar that can be used to validate VAT IDs'
  s.authors       = ['TaxJar']
  s.email         = 'support@taxjar.com'
  s.files         = ['lib/vat_check.rb', 'lib/vat_check/format.rb', 'lib/vat_check/requests.rb', 'lib/vat_check/utility.rb']
  s.require_paths = ['lib']
  s.homepage      = 'http://taxjar.com'
  s.required_ruby_version = '>= 2.1.6'
  s.metadata      = { 'source_code_uri' => 'https://github.com/taxjar/vat_check' }

  s.add_runtime_dependency      'savon',    '~> 2.11',  '>= 2.11.0'
  s.add_development_dependency  'rspec',    '~> 3.4'
  s.add_development_dependency  'vcr',      '~> 3.0',   '>= 3.0.1'
  s.add_development_dependency  'webmock',  '~> 3.8',  '>= 3.8.3'
  s.add_development_dependency  'mocha',    '~> 1.1',   '>= 1.1.0'
end
