require 'spec_helper'

RSpec.describe Frontier::Spec::FeatureSpecActingAs do

  describe '#to_s' do
    subject { Frontier::Spec::FeatureSpecActingAs.new(model).to_s }
    let(:model) do
      Frontier::Model.new(model_name: {})
    end

    let(:expected) do
      raw = <<~STRING
        fill_in('model_name[name_en]',        with: model_name_attributes[:name_en])
        fill_in('model_name[description_en]', with: model_name_attributes[:description_en])
        fill_in('model_name[hopoff_url_en]',  with: model_name_attributes[:hopoff_url_en])
        within('.model_name_provider_id') do
          semantic_select(selector: '#model_name_provider_id', value: provider.id.to_s)
        end
STRING
      raw.strip
    end

    it { is_expected.to eq(expected) }
  end
end
