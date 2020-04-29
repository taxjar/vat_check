require 'vat_check/utility'
require 'vat_check/format'
require 'vat_check/requests'
require 'vat_check/version'

class VatCheck
  attr_reader :regex, :vies, :vies_available, :response

  def initialize(vat)
    @vat = vat
    @regex = VatCheck::Format.valid?(@vat)
    @response = @regex ? VatCheck::Request.lookup(@vat) : {}
    @vies_available = @response.has_key?(:valid)
    @vies = @vies_available ? @response[:valid] : false
  end

  def valid?
    return false unless @regex
    return @regex unless @vies_available
    return @vies
  end

  def exists?
    return @vies
  end
end