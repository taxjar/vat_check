class TaxJarVat

  def self.lookup(vat)
    valid = TaxJarVat::Format.valid?(vat)
    response = TaxJarVat::Request.exists(vat) if valid
    to_return = {}
    to_return[:valid] = valid
    unless valid
      to_return[:exists] = false
    else
      to_return[:exists] = response.has_key?(:error) ? false : response[:valid]
      to_return[:response] = response
    end
    to_return
  end

  def self.valid?(vat)
    TaxJarVat::Format.valid?(vat)
  end

  def self.exists?(vat)
    if TaxJarVat::Format.valid?(vat)
      response = TaxJarVat::Request.exists(vat)
      return response.has_key?(:valid) ? response[:valid] : false
    end

    return false
  end
end

require 'taxjarvat/utility'
require 'taxjarvat/format'
require 'taxjarvat/requests'