# frozen_string_literal: true

require 'open-uri'

class WebsiteScanner
  def initialize(params)
    @uri = params[:uri]
  end

  def send_request
    @nokogiri_document = begin
                           Nokogiri::HTML(open(@uri))
                         rescue OpenURI::HTTPError => e
                           nil
                         rescue TypeError => e
                           nil
                         rescue Errno::ECONNREFUSED => e
                           nil
                         end
  end

  def get_anchors
    @nokogiri_document&.xpath('//a/@href') || []
  end

  def get_images
    @nokogiri_document&.xpath('//img/@src') || []
  end
end
