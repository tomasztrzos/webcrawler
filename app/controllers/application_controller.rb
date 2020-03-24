# frozen_string_literal: true

class ApplicationController < ActionController::API
  def index
    render plain: "Webcrawler by Tomasz Trzos. Environment: #{Rails.env}"
  end
end
