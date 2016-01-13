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

  context 'service is available' do
    it 'returns the expected information with a valid VAT', vcr: { cassette_name: 'requests/service_available_valid_vat', record: :none } do
      response = TaxJarVat.validate('GB333289454')
      expect(response[:format_valid]).to eq(true)

      validation = response[:validation]
      expect(validation[:country_code]).to eq('GB')
      expect(validation[:vat_number]).to eq('333289454')
      expect(validation[:valid]).to eq(true)
      expect(validation[:name]).to eq('BRITISH BROADCASTING CORPORATION')
      expect(validation[:address].gsub("\n", " ")).to eq('FAO ALEX FITZPATRICK BBC GROUP VAT MANAGER THE LIGHT HOUSE (1ST FLOOR) MEDIA VILLAGE, 201 WOOD LANE LONDON W12 7TQ')
    end

    it 'returns the expected response for a valid but unknown VAT', vcr: { cassette_name: 'requests/service_available_valid_but_unknown_vat', record: :none } do
      response = TaxJarVat.validate('GB999999999')
      expect(response[:format_valid]).to eq(true)

      validation = response[:validation]
      expect(validation[:country_code]).to eq('GB')
      expect(validation[:vat_number]).to eq('999999999')
      expect(validation[:valid]).to eq(false)
      expect(validation[:name]).to eq('---')
      expect(validation[:address]).to eq('---')
    end
  end
end