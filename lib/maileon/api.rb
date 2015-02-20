require 'base64'
require 'excon'

module Maileon
  class API

    def initialize(apikey=nil, debug=false)
      @host = 'https://api.maileon.com'
      @path = '/1.0/'

      unless apikey
        apikey = ENV['MAILEON_APIKEY']
      end

      raise 'You must provide Maileon API key' unless apikey

      @apikey = Base64.encode64(apikey).strip
      @debug = debug
      @session = Excon.new @host, :debug => debug
    end

  end
end