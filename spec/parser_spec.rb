# frozen_string_literal: true

require_relative '../app/parser'

describe Parser do
  before do
    @data = Parser.new('spec/test_data/webserver.log').parse
  end

  it 'should return correct hash keys' do
    expect(@data.keys.size).to eq(4)
    expect(@data.keys).to include('help_page/1', 'contact', '/about/2', 'index')
  end

  it 'should return correct hash values' do
    expect(@data.values.size).to eq(4)
    expect(@data.values.sample.keys).to eq([:total, :uniq])
  end

  it 'should return correct values for specific page' do
    expect(@data['contact']).to eq({ total: 2, uniq: 1 })
  end
end