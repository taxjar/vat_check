class TaxJarVat

  def self.validate(raw)
    response = {}
    response[:format_valid] = TaxJarVat::Format.valid?(raw)

    begin
      if response[:format_valid]
        vat = TaxJarVat::Utility.normalize(raw)
        country_code, id = TaxJarVat::Utility.split(vat)
        response.merge!(TaxJarVat::Requests.validate(country_code, id))
      end
    rescue Savon::SOAPFault => e
      if !!(e.message =~ /MS_UNAVAILABLE/)
        response[:valid] = 'Service unavailable'
      else
        response[:valid] = "Unknown error: #{e.message}"
      end
    rescue Timeout::Error
      response[:valid] = 'Service timed out'
    end

    response
  end

end

require 'taxjarvat/utility'
require 'taxjarvat/format'
require 'taxjarvat/requests'