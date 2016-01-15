require 'spec_helper'

describe VatCheck::Format do
  valid_vat_ids = [
    'ATU99999999',        # AT-Austria
    'BE0999999999',       # BE-Belgium
    'BG999999999',        # BG-Bulgaria
    'BG9999999999',       # BG-Bulgaria
    'CY99999999L',        # CY-Cyprus
    'CZ99999999',         # CZ-Czech Republic
    'CZ999999999',        # CZ-Czech Republic
    'CZ9999999999',       # CZ-Czech Republic
    'DE999999999',        # DE-Germany
    'DK99 99 99 99',      # DK-Denmark
    'EE999999999',        # EE-Estonia
    'EL999999999',        # EL999999999
    'ESX9999999X',        # ES-Spain
    'FI99999999',         # FI-Finland
    'FRXX 999999999',     # FR-France
    'GB999 9999 99',      # GB-United Kingdom
    'GB999 9999 99 999',  # GB-United Kingdom
    'GBGD999',            # GB-United Kingdom
    'GBHA999',            # GB-United Kingdom
    'HR99999999999',      # HR-Croatia
    'HU99999999',         # HU-Hungary
    'IE9S99999L',         # IE-Ireland
    'IE9999999WI',        # IE-Ireland
    'IT99999999999',      # IT-Italy
    'LT999999999',        # LT-Lithuania
    'LT999999999999',     # LT-Lithuania
    'LU99999999',         # LU-Luxembourg
    'LV99999999999',      # LV-Latvia
    'MT99999999',         # MT-Malta
    'NL999999999B99',     # NL-The Netherlands
    'PL9999999999',       # PL-Poland
    'PT999999999',        # PT-Portugal
    'RO999999999',        # RO-Romania
    'SE999999999999',     # SE-Sweden
    'SI99999999',         # SI-Slovenia
    'SK9999999999',       # SK-Slovakia
  ]

  invalid_vat_ids = [
    'XX',
    'XX9999999999',
    '123456789'
  ]

  context "valid VAT ID:" do
    valid_vat_ids.each do |id|
      it "#{id} validates" do
        expect(VatCheck::Format.valid?(id)).to be_truthy
      end
    end
  end

  context "invalid VAD ID: " do
    invalid_vat_ids.each do |id|
      it "#{id} does not validate" do
        expect(VatCheck::Format.valid?(id)).to be_falsey
      end
    end
  end
end