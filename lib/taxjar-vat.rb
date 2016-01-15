class TaxJarVat

  def self.lookup(vat)
    valid = TaxJarVat::Format.valid?(vat)
    response = TaxJarVat::Request.exists(vat) if valid
    data = {}
    data[:valid] = valid
    unless valid
      data[:exists] = false
    else
      data[:exists] = response.has_key?(:error) ? false : response[:valid]
      data[:response] = response
    end
    data
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