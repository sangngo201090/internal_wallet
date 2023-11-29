require_relative "latest_stock_price_gem/version"
require 'net/http'
require 'json'

module LatestStockPriceGem
    class LatestStockPriceGem
        # replace with your RapidAPI key
        API_KEY = 'YOUR_RAPIDAPI_KEY'
        API_ENDPOINT = 'https://latest-stock-price.p.rapidapi.com'
      
        def price(indices, identifier=nil)
            # Check indices is not nil
            raise ArgumentError, 'Indices cannot be nil' if indices.nil?

            uri = URI("#{API_ENDPOINT}/price")
            make_request(uri, indices, identifier)
        end
      
        def prices(indices, identifiers=nil)
            # Check indices is not nil
            raise ArgumentError, 'Indices cannot be nil' if indices.nil?
            uri = URI("#{API_ENDPOINT}/prices")
            make_request(uri, indices, identifiers)
        end
      
        def price_all(identifiers=nil)
            uri = URI("#{API_ENDPOINT}/price_all")
            make_request(uri, nil, identifiers)
        end
      
        private

        def make_request(uri, indices_param = nil, identifier_param = nil)
            # Build the URI with the additional parameters if provided
            params = {}
            params[:Indices] = indices_param if indices_param
            params[:Identifier] = identifier_param if identifier_param
          
            uri.query = URI.encode_www_form(params) unless params.empty?
          
            request = Net::HTTP::Get.new(uri)
            request['X-RapidAPI-Key'] = API_KEY
          
            response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
                http.request(request)
            end
          
            JSON.parse(response.body)
        end
    end
end