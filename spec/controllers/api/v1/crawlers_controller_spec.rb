# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::CrawlersController, type: :request do
  describe 'GET /show' do
    subject { get('/api/v1/scan', params: params) }

    context 'invalid url' do
      let!(:url) { 'http-sample-wrong-url' }
      let!(:params) { { url: url } }

      before do
        expect_any_instance_of(Spider).to receive(:scan_website).and_return({})
      end

      it 'returns correct content' do
        subject
        expect(JSON.parse(response.body)).to eq({})
      end
    end

    context 'valid url' do
      let!(:url) { 'http://sample.com' }
      let!(:params) { { url: url } }

      before do
        expect_any_instance_of(Spider).to receive(:scan_website).and_return(
          {
            'http://sample.com': {
              domain_urls: [],
              external_urls: [],
              images_urls: []
            }
          }
        )
      end

      it 'returns correct content' do
        subject
        expect(JSON.parse(response.body)).to eq({ 'http://sample.com' => { 'domain_urls' => [], 'external_urls' => [], 'images_urls' => [] } })
      end

      it 'returns correct http code' do
        subject
        expect(response.status).to eq 200
      end
    end
  end
end
