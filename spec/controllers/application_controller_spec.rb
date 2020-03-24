# frozen_string_literal: true

require 'rails_helper'

describe ApplicationController, type: :controller do
  describe 'GET /index' do
    subject { get :index }

    before do
      subject
    end

    it 'returns correct content' do
      expect(response.body).to eq "Webcrawler by Tomasz Trzos. Environment: #{Rails.env}"
    end

    it 'returns correct http code' do
      expect(response.status).to eq 200
    end
  end
end
