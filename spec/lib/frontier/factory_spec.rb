require 'spec_helper'

describe Frontier::Factory do

  describe "#to_s" do
    subject { factory.to_s }
    let(:factory) { Frontier::Factory.new(model) }
    let(:model) do
      Frontier::Model.new({
        user: {
          attributes: {
            first_name: {type: "string"},
            surname: {type: "string"},
            address: {type: "belongs_to"}
          }
        }
      })
    end

    let(:expected) do
      raw = <<STRING
FactoryBot.define do
  factory :user do
    association :address, strategy: :build
    first_name { FFaker::Name.first_name }
    surname    { FFaker::Name.last_name }

    trait :invalid do
      address    nil
      first_name nil
      surname    nil
    end
  end
end
STRING
      raw.rstrip
    end

    it { is_expected.to eq(expected) }

  end

  describe '#engine_to_s' do
    subject { factory.engine_to_s }
    let(:factory) { Frontier::Factory.new(model) }
    let(:model) do
      Frontier::Model.new({
        user: {
          engine_name: 'engine_one',
          acting_as: true,
          attributes: {
            first_name: {type: "string"},
            surname: {type: "string"},
            address: {type: "belongs_to"}
          }
        }
      })
    end

    let(:expected) do
      raw = <<STRING
FactoryBot.define do
  factory :engine_one_user, class: 'EngineOne::User' do
    association :provider, factory: :ms_core_provider, channel_names: ['Engine One']
    status 'draft'
    slug { FFaker::Internet.slug }
    I18n.available_locales.each do |locale|
      sequence(('name_'.concat(locale.to_s.tr('-', '_')).to_sym) { |_n| FFaker::Name.name }
      sequence(('description_'.concat(locale.to_s.tr('-', '_')).to_sym) { |_n| FFaker::Lorem.sentence }
      sequence(('hopoff_url_'.concat(locale.to_s.tr('-', '_')).to_sym) { |_n| FFaker::Internet.http_url }
    end

    association :address, strategy: :build
    first_name { FFaker::Name.first_name }
    surname    { FFaker::Name.last_name }

    trait :invalid do
      address    nil
      first_name nil
      surname    nil
    end
  end
end
STRING
      raw.rstrip
    end

    it { is_expected.to eq(expected) }
  end

end
