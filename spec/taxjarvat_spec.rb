require 'spec_helper'

describe TaxJarVat do

  context 'service unavailable', vcr: { cassette_name: 'requests/validate_ms_unavailable_error', record: :none } do
    it 'gracefully handles the exception' do
      response = TaxJarVat.validate('GB333289454')
      expect(response[:validation]).to eq('Service unavailable')
    end

    it 'still validates the format' do
      response = TaxJarVat.validate('GB333289454')
      expect(response[:format_valid]).to eq(true)
    end
  end

  context 'service times out' do
    before { TaxJarVat::Requests.stubs(:validate).raises(Timeout::Error)}

    it 'gracefully handles the exception' do
      response = TaxJarVat.validate('GB333289454')
      expect(response[:validation]).to eq('Service timed out')
    end

    it 'still validates the format' do
      response = TaxJarVat.validate('GB333289454')
      expect(response[:format_valid]).to eq(true)
    end
  end
end