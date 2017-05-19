module Maileon
  class API

    attr_accessor :host, :path, :config, :session

    # XXX: parameters to be replaced with options parameter in 1.0.0.
    def initialize(apikey=nil, debug=false)

      @host = 'https://api.maileon.com'
      @path = '/1.0/'

      if apikey.nil? && !debug
        @config = Maileon::Config.new
      else
        @config = Maileon::Config.new({ :apikey => apikey, :debug => debug })
      end

      @session = Excon.new @host, :debug => @config.debug
    end

    def ping
      @session.get(:path => "#{@path}/ping", :headers => get_headers)
    end

    def create_contact(params, body={})
      raise ArgumentError.new("No parameters.") if params.empty?
      raise ArgumentError.new("Email is mandatory.") if params[:email].nil?
      raise Maileon::Errors::ValidationError.new("Invalid email format.") unless is_valid_email(params[:email])
      email = URI::escape(params[:email])
      permission = params[:permission] ||= 1
      sync_mode = params[:sync_mode] ||= 2
      src = params[:src]
      subscription_page = params[:subscription_page]
      doi = params[:doi] ||= true
      doiplus = params[:doiplus] ||= true
      doimailing = params[:doimailing]
      url = "contacts/#{email}?permission=#{permission}&sync_mode=#{sync_mode}&doi=#{doi}&doiplus=#{doiplus}"
      url << "&doimailing=#{doimailing}" unless doimailing.nil?
      url << "&src=#{src}" unless src.nil?
      url << "&subscription_page=#{subscription_page}" unless subscription_page.nil?
      @session.post(:path => "#{@path}#{url}", :headers => get_headers, :body => body.to_json)
    end

    def delete_contact(params)
      raise ArgumentError.new("No parameters.") if params.empty?
      raise ArgumentError.new("Email is mandatory.") if params[:email].nil?
      raise Maileon::Errors::ValidationError.new("Invalid email format.") unless is_valid_email(params[:email])
      email = URI::escape(params[:email])
      url = "contacts/#{email}"
      @session.delete(:path => "#{@path}#{url}", :headers => get_headers('xml'))
    end

    private

    def get_headers(type='json')
      {
        "Content-Type" => "application/vnd.maileon.api+#{type}; charset=utf-8",
        "Authorization" => "Basic #{@config.apikey}"
      }
    end

    def is_valid_email(email)
      !/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/.match(email).nil?
    end

  end
end
