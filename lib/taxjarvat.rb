class TaxJarVat

  def self.lookup(vat)
    valid = TaxJarVat::Format.valid?(vat)
    {
      valid: valid,
      exists: valid ? TaxJarVat::Request.exists(vat) : false
    }
  end

  def self.valid?(vat)
    TaxJarVat::Format.valid?(vat)
  end

  def self.exists?(vat)
    if TaxJarVat::Format.valid?(vat)
      response = TaxJarVat::Request.exists(vat)
      return response.is_a?(Hash) ? response[:valid] : response
    end

    return false
  end
end

require 'taxjarvat/utility'
require 'taxjarvat/format'
require 'taxjarvat/requests'