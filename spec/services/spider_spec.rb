# frozen_string_literal: true

require 'rails_helper'

describe Spider do
  describe '#scan_website' do
    subject { described_class.new(params).scan_website }

    context 'blank params' do
      let!(:params) { { url: '' } }

      it 'returns nil' do
        expect(subject).to eq(nil)
      end
    end

    context 'invalid url' do
      let!(:params) { { url: 'http/:invalid-website.com' } }

      it 'returns nil' do
        expect(subject).to eq(nil)
      end
    end

    context 'valid url' do
      let!(:params) { { url: 'http://sample.com/' } }

      it 'returns hash with domain_urls, external_urls and images_urls' do
        VCR.use_cassette 'services/spider/sample_response_200' do
          expect(subject).to eq(
            {
              'http://sample.com/' =>
                {
                  domain_urls: [],
                  external_urls: ['http://www.ccin.com/'],
                  images_urls: ['images/sample.png', 'http://www.savaii.com/images/ccinlogo1.gif', 'http://www.savaii.com/images/copylink.gif']
                }
            }
          )
        end
      end
    end
  end
end
