# frozen_string_literal: true

RSpec.describe PerTenantFieldMappings, type: :decorator do
  before do
    allow(Site).to receive(:account).and_return(account)
  end

  context 'when the current Account does not have any tenant-specific field mappings' do
    let(:account) { build(:account) }

    it "returns Bulkrax's default field mappings" do
      default_bulkrax_mapping_keys = ['Bulkrax::OaiDcParser', 'Bulkrax::OaiQualifiedDcParser', 'Bulkrax::CsvParser', 'Bulkrax::BagitParser', 'Bulkrax::XmlParser']

      expect(Site.account.settings['bulkrax_field_mappings']).to be_nil
      expect(Bulkrax.field_mappings).to be_a(Hash)
      expect(Bulkrax.field_mappings.keys.sort).to eq(default_bulkrax_mapping_keys.sort)
    end
  end

  context 'when the current Account has tenant-specific field mappings' do
    let(:account) { build(:account, settings: { bulkrax_field_mappings: field_mapping_json }) }
    let(:field_mapping_json) do
      {
        'Bulkrax::CsvParser' => {
          'fake_field' => { from: %w[fake_column], split: /\s*[|]\s*/ }
        }
      }.to_json
    end

    it "returns the tenant's custom field mappings" do
      expect(Bulkrax.field_mappings).to eq(JSON.parse(Site.account.bulkrax_field_mappings))
    end
  end
end
