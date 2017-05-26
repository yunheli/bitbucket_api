require 'bitbucket/version'
require 'bitbucket/configuration'

module Bitbucket
  class << self
    def new(options)
      
    end

    def config
      @config ||= Configuration.new
    end

    def configure
      yield config if block_given?
    end
  end
end
