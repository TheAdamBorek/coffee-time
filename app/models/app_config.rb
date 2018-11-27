require 'singleton'
require 'yaml'

class AppConfig
  include Singleton

  def initialize
    @config = YAML.load_file("config/app_config.yml")[Rails.env]
    if @config.empty?
      raise IOError("App Config shouldn't be empty")
    end
  end

  def slack_hook_url
    @config['slack_hook_url']
  end
end