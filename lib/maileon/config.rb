module Maileon

  class Config

    attr_reader :apikey, :debug


    def initialize(options = nil)

      @config = {
        :apikey => nil,
        :debug => false
      }

      @valid_keys = @config.keys

      if options.nil?
        configure_with_yaml
      else
        configure(options)
      end

      process_api_code

    end

    def apikey
      @config[:apikey]
    end

    def debug
      @config[:debug]
    end

    private

    def configure(options = {})
      options.each do |key, value|
        unless key.nil? || !@valid_keys.include?(key.to_sym)
          @config[key.to_sym] = value
        end
      end
    end

    def configure_with_yaml
      if defined?(Rails) && Rails.env
        file = File.join(Rails.root, 'config/maileon.yml')
        begin
          config = YAML.load_file(file)[Rails.env] if File.exists?(file)
        rescue Errno::ENOENT
          log :warning, "YAML configuration file not found. Using defaults."
          return
        rescue Psych::SyntaxError
          log :warning, "YAML configuration file with invalid syntax. Using defaults."
          return
        end
      end
      configure(config)
    end

    def process_api_code
      if @config[:apikey].nil? && !ENV['MAILEON_APIKEY']
        raise 'You must provide Maileon API key'
      elsif @config[:apikey].nil? && ENV['MAILEON_APIKEY']
        @config[:apikey] = ENV['MAILEON_APIKEY']
      end
      @config[:apikey] = Base64.encode64(@config[:apikey]).strip
    end

  end

end
