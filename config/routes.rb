# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'application#index'

  namespace 'api' do
    namespace 'v1' do
      get 'scan', to: 'crawlers#show'
    end
  end
end
