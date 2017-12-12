require 'spec_helper'

describe Frontier::Views::Index::TableHeading do

  describe "#to_s" do
    subject { table_heading.to_s }

    let(:table_heading) { Frontier::Views::Index::TableHeading.new(attribute) }
    let(:model) do
      Frontier::Model.new({
        test_model: {
          attributes: {name: {sortable: sortable}}
        }
      })
    end
    let(:attribute) { model.attributes.first }

    context "sortable" do
      let(:sortable) { true }
      it { is_expected.to eq("%th= sort_link(@ransack_query, :name, \"Name\")") }
    end

    context "not sortable" do
      let(:sortable) { false }
      it { is_expected.to eq("%th Name") }
    end
  end

end
