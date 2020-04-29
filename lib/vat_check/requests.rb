require 'savon'

class VatCheck
  module Request
    def self.lookup(vat)
      client = Savon.client(wsdl: 'https://ec.europa.eu/taxation_customs/vies/checkVatService.wsdl', follow_redirects: true, log: false, log_level: :debug, pretty_print_xml: false)
      country_code, vat_number = VatCheck::Utility.split(vat)
      begin
        response = client.call(:check_vat, message: {country_code: country_code, vat_number: vat_number}, message_tag: :checkVat)
        response.to_hash[:check_vat_response].reject { |key| key == :@xmlns }
      rescue Savon::SOAPFault => e
        if !!(e.message =~ /MS_UNAVAILABLE/)
          return {error:'Service unavailable'}
        else
          return {error:"Unknown error: #{e.message}"}
        end
      rescue Timeout::Error
        return {error:'Service timed out'}
      end
    end
  end
end
