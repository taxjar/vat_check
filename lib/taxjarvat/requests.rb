require 'savon'

class TaxJarVat
  module Request
    def self.exists(vat)
      client = Savon.client(wsdl: 'http://ec.europa.eu/taxation_customs/vies/checkVatService.wsdl', log: false, log_level: :debug, pretty_print_xml: false)
      country_code, vat_number = TaxJarVat::Utility.split(vat)
      begin
        response = client.call(:check_vat, message: {country_code: country_code, vat_number: vat_number}, message_tag: :checkVat)
        return response.to_hash[:check_vat_response]
      rescue Savon::SOAPFault => e
        if !!(e.message =~ /MS_UNAVAILABLE/)
          return 'Service unavailable'
        else
          return "Unknown error: #{e.message}"
        end
      rescue Timeout::Error
        return 'Service timed out'
      end
    end
  end
end