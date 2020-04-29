Gem::Specification.new do |s|
  s.name          = 'vat_check'
  s.version       = '0.0.5'
  s.licenses      = ['MIT']
  s.summary       = 'Validate VAT IDs'
  s.description   = 'A gem by TaxJar that can be used to validate VAT IDs'
  s.authors       = ['TaxJar']
  s.email         = 'support@taxjar.com'
  s.files         = ['lib/vat_check.rb', 'lib/vat_check/format.rb', 'lib/vat_check/requests.rb', 'lib/vat_check/utility.rb']
  s.require_paths = ['lib']
  s.homepage      = 'https://taxjar.com'
  s.metadata      = { 'source_code_uri' => 'https://github.com/taxjar/vat_check' }

  s.required_ruby_version = '>= 2.3'

  s.add_runtime_dependency      'savon',    '~> 2.12',  '>= 2.12.0'
  s.add_development_dependency  'rspec',    '~> 3.4'
  s.add_development_dependency  'vcr',      '~> 5.1',   '>= 5.1.0'
  s.add_development_dependency  'webmock',  '~> 3.8',  '>= 3.8.3'
  s.add_development_dependency  'mocha',    '~> 1.1',   '>= 1.1.0'
end
