# frozen_string_literal: true

require 'redis'

class Api::V1::CrawlersController < ApplicationController
  def show
    hash = Rails.cache.fetch("websites/#{crawler_params[:url]}", expires_in: 10.minutes) do
      Spider.new(url: crawler_params[:url]).scan_website
    end

    render json: hash, status: :ok
  end

  private

  def crawler_params
    params.permit(
      :url
    )
  end
end
