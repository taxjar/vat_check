require 'savon'

class TaxJarVat
  module Requests
    def self.validate(country_code, vat_number)
      client = Savon.client(wsdl: 'http://ec.europa.eu/taxation_customs/vies/checkVatService.wsdl', log: false, log_level: :debug, pretty_print_xml: false)
      response = client.call(:check_vat, message: {country_code: country_code, vat_number: vat_number}, message_tag: :checkVat)
      response.to_hash[:check_vat_response]
    end
  end
end