module Bitbucket
  class Configuration
    class << self
      def property(key, options={})
        @keys ||= []
        @keys << key
        class_eval do
          attr_accessor key
          unless options[:default].nil?
            define_method key do
              data = self.instance_variable_get("@#{key}") 
              data ||= options[:default]
              data
            end
          end
        end
      end

      attr_reader :keys
    end

    property :client_id
    property :client_secret
    property :redirect_uri
    property :auto_pagination, default: true
    property :scope
    property :access_token
    property :refresh_token
    property :raw_data, default: false
    property :per_page, default: 100
    property :page, default: 1
    property :auto_refresh, default: true
    property :timeout, default: 30
  end
end