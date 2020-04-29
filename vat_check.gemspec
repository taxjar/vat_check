lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vat_check/version'

Gem::Specification.new do |s|
  s.name          = 'vat_check'
  s.version       = VatCheck::VERSION
  s.authors       = ['TaxJar']
  s.email         = 'support@taxjar.com'

  s.summary       = 'Validate VAT IDs'
  s.description   = 'A gem by TaxJar that can be used to validate VAT IDs'
  s.homepage      = 'https://taxjar.com'
  s.license       = 'MIT'

  if s.respond_to?(:metadata)
    s.metadata['source_code_uri'] = 'https://github.com/taxjar/vat_check'
    s.metadata['bug_tracker_uri'] = 'https://github.com/taxjar/vat_check/issues'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  s.require_paths = ['lib']
  s.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  s.required_ruby_version = '>= 2.3'

  s.add_runtime_dependency      'savon',    '~> 2.12',  '>= 2.12.0'

  s.add_development_dependency  'rspec',    '~> 3.4'
  s.add_development_dependency  'vcr',      '~> 5.1',   '>= 5.1.0'
  s.add_development_dependency  'webmock',  '~> 3.8',  '>= 3.8.3'
  s.add_development_dependency  'mocha',    '~> 1.1',   '>= 1.1.0'
end
