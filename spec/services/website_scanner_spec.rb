# frozen_string_literal: true

require 'rails_helper'

describe WebsiteScanner do
  describe '#send_request' do
    subject { described_class.new(params).send_request }

    context 'invalid uri' do
      let!(:params) { { uri: URI.parse('http/:invalid-website.com') } }

      it 'returns nil' do
        expect(subject).to eq(nil)
      end
    end

    context 'correct uri' do
      let!(:params) { { uri: URI.parse('http://sample.com/') } }

      it 'returns instance of Nokogiri html document' do
        VCR.use_cassette 'services/website_scanner/sample_response_200' do
          expect(subject).to be_a Nokogiri::HTML::Document
        end
      end
    end
  end
end
