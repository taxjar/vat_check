require 'spec_helper'

describe TaxJarVat::Request do
  context 'service unavailable', vcr: { cassette_name: 'requests/validate_ms_unavailable_error', record: :none } do
    it 'gracefully handles the exception' do
      response = TaxJarVat::Request.exists('GB333289454')
      expect(response).to eq({:error=>"Service unavailable"})
    end
  end

  context 'service is available' do
    it 'returns the expected information with a valid VAT', vcr: { cassette_name: 'requests/service_available_valid_vat', record: :none } do
      response = TaxJarVat::Request.exists('GB333289454')

      expect(response[:country_code]).to eq('GB')
      expect(response[:vat_number]).to eq('333289454')
      expect(response[:valid]).to eq(true)
      expect(response[:name]).to eq('BRITISH BROADCASTING CORPORATION')
      expect(response[:address].gsub("\n", " ")).to eq('FAO ALEX FITZPATRICK BBC GROUP VAT MANAGER THE LIGHT HOUSE (1ST FLOOR) MEDIA VILLAGE, 201 WOOD LANE LONDON W12 7TQ')
    end

    it 'returns the expected response for a valid but unknown VAT', vcr: { cassette_name: 'requests/service_available_valid_but_unknown_vat', record: :none } do
      response = TaxJarVat::Request.exists('GB999999999')

      expect(response[:country_code]).to eq('GB')
      expect(response[:vat_number]).to eq('999999999')
      expect(response[:valid]).to eq(false)
      expect(response[:name]).to eq('---')
      expect(response[:address]).to eq('---')
    end

    it 'does not include the xmlns field', vcr: { cassette_name: 'requests/service_available_valid_vat', record: :none } do
      response = TaxJarVat::Request.exists('GB333289454')
      expect(response).to_not have_key(:@xmlns)
    end
  end
end