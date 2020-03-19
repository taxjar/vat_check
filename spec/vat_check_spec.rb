require 'spec_helper'

describe VatCheck do

  context 'an invalid vat' do
    let(:vat) { VatCheck.new('XX123456789') }

    it 'returns false for valid and exists' do
      expect(vat.valid?).to be_falsey
      expect(vat.exists?).to be_falsey
    end

    it 'returns an empty response' do
      expect(vat.response).to eq({})
    end

    it 'has set both regex and vies to false' do
      expect(vat.regex).to be_falsey
      expect(vat.vies).to be_falsey
    end
  end

  context 'a valid vat and known vat and vies is available', vcr: { cassette_name: 'requests/service_available_valid_vat', record: :none } do
    let(:vat) { VatCheck.new('GB333289454') }

    it 'returns true for valid? and and exists?' do
      expect(vat.valid?).to be_truthy
      expect(vat.exists?).to be_truthy
    end

    it 'contains the expected response' do
      expect(vat.response[:country_code]).to eq('GB')
      expect(vat.response[:vat_number]).to eq('333289454')
      expect(vat.response[:valid]).to eq(true)
      expect(vat.response[:name]).to eq('BRITISH BROADCASTING CORPORATION')
      expect(vat.response[:address].gsub("\n", " ")).to eq('FAO ALEX FITZPATRICK BBC GROUP VAT MANAGER THE LIGHT HOUSE (1ST FLOOR) MEDIA VILLAGE, 201 WOOD LANE LONDON W12 7TQ')
    end

    it 'has regex set to false and vies set to false' do
      expect(vat.regex).to be_truthy
      expect(vat.vies).to be_truthy
    end

    it 'shows that vies is available' do
      expect(vat.vies_available).to be_truthy
    end
  end

  context 'a valid but unkown vat and vies is available', vcr: { cassette_name: 'requests/service_available_valid_but_unknown_vat', record: :none } do
    let(:vat) { VatCheck.new('GB999999999') }

    it 'returns false for valid and exists' do
      expect(vat.valid?).to be_falsey
      expect(vat.exists?).to be_falsey
    end

    it 'returns the expected response' do
      expect(vat.response[:country_code]).to eq('GB')
      expect(vat.response[:vat_number]).to eq('999999999')
      expect(vat.response[:valid]).to eq(false)
      expect(vat.response[:name]).to eq('---')
      expect(vat.response[:address]).to eq('---')
    end

    it 'has regex set to false and vies set to false' do
      expect(vat.regex).to be_truthy
      expect(vat.vies).to be_falsey
    end

    it 'shows that vies is available' do
      expect(vat.vies_available).to be_truthy
    end
  end

  context 'when vies is unavailable and vat is valid', vcr: { cassette_name: 'requests/validate_ms_unavailable_error', record: :none } do
    let(:vat) { VatCheck.new('GB333289454') }

    it 'returns true for valid and false for exists' do
      expect(vat.valid?).to be_truthy
      expect(vat.exists?).to be_falsey
    end

    it 'returns the error message in the response' do
      expect(vat.response).to eq(:error=>"Service unavailable")
    end

    it 'shows that vies is unavailable' do
      expect(vat.vies_available).to be_falsey
    end
  end
end
