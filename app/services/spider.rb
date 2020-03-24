# frozen_string_literal: true

class Spider
  def initialize(params)
    @start_url = params[:url]
    @website_map = {}
    @counter = 0
  end

  def scan_website
    return if start_url.blank?

    start_normalized_uri = normalize_url(@start_url)
    return if start_normalized_uri.host.blank?

    @start_host = start_normalized_uri.host&.gsub('www.', '')

    start_crawling(start_normalized_uri)

    website_map
  end

  attr_accessor :website_map, :requested_urls, :start_url, :start_host

  private

  def normalize_url(url)
    cleaned_url = url.last.eql?('/') ? url.chop : url
    URI.parse(cleaned_url).normalize
  rescue URI::InvalidURIError
    URI.parse(CGI.escape(cleaned_url)).normalize
  end

  def add_result_to_website_map(uri, domain_urls, external_urls, images_urls)
    website_map.store(
      uri.to_s,
      {
        domain_urls: domain_urls,
        external_urls: external_urls,
        images_urls: images_urls
      }
    )
  end

  def get_not_requested_domain_uris(requested_uri, uris)
    uris.uniq
        .select do |uri|
      uri != requested_uri &&
        uri.fragment.nil? &&
        uri.host.present? &&
        uri.host.include?(start_host) &&
        uri.host.gsub('www.', '') == start_host &&
        @website_map.keys.exclude?(uri.to_s)
    end
  end

  def get_domain_urls(uris)
    uris.select do |external_uri|
      external_uri.host.present? && external_uri.host.gsub('www.', '') == start_host
    end.collect(&:to_s).uniq
  end

  def get_external_urls(uris)
    uris.select do |external_uri|
      external_uri.host.present? && external_uri.host.gsub('www.', '') != start_host
    end.collect(&:to_s).uniq
  end

  def start_crawling(uri)
    @counter += 1
    return if @counter > 300

    website_scanner = WebsiteScanner.new(uri: uri)
    website_scanner.send_request

    anchors = website_scanner.get_anchors
    images = website_scanner.get_images

    normalized_anchors_uris = anchors.collect { |anchor| normalize_url(anchor.value) }

    domain_urls = get_domain_urls(normalized_anchors_uris)
    external_urls = get_external_urls(normalized_anchors_uris)
    images_urls = images.collect(&:value)

    add_result_to_website_map(uri, domain_urls, external_urls, images_urls)

    domain_anchors_uris = get_not_requested_domain_uris(uri, normalized_anchors_uris)
    return if domain_anchors_uris.empty?

    domain_anchors_uris.each do |next_uri|
      next if @website_map.keys.include?(next_uri.to_s)

      start_crawling(next_uri)
    end
  end
end
