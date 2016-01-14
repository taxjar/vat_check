class TaxJarVat

  def self.validate(raw)
    response = {}
    response[:format_valid] = TaxJarVat::Format.valid?(raw)

    begin
      vat = TaxJarVat::Utility.normalize(raw)
      country_code, id = TaxJarVat::Utility.split(vat)
      response.merge!(TaxJarVat::Requests.validate(country_code, id))
    rescue Savon::SOAPFault => e
      if !!(e.message =~ /MS_UNAVAILABLE/)
        response[:validation] = 'Service unavailable'
      else
        response[:validation] = "Unknown error: #{e.message}"
      end
    rescue Timeout::Error
      response[:validation] = 'Service timed out'
    end

    response
  end

end

require 'taxjarvat/utility'
require 'taxjarvat/format'
require 'taxjarvat/requests'