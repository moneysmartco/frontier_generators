require 'rails_helper'

module <%= model.engine_name.camelize %>
  describe <%= model.name.as_constant%>Decorator do
    let(:<%= model.name.as_singular %>) { create(:<%= model.engine_name %>_<%= model.name.as_singular %>, hopoff_url: hopoff_url) }

    let(:hopoff_url) { 'http://google.com' }
    let(:decorated_<%= model.name.as_singular %>) { <%= model.name.as_singular %>.decorate }

    describe '#hopoff_url' do
      subject { decorated_<%= model.name.as_singular %>.hopoff_url }

      context '<%= model.name.as_singular %> hopoff_url does present' do
        it { is_expected.to eq hopoff_url }
      end

      context '<%= model.name.as_singular %> hopoff_url does not present' do
        let(:hopoff_url) { nil }

        it { is_expected.to eq hopoff_url }
      end
    end

  end
end
