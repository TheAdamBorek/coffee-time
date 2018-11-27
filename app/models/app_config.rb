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
    url = @config['slack_hook_url']
    if url.blank?
      url = ENV['SLACK_HOOK_URL']
    end
    URI(url)
  end

  def hangouts_redirect_url
    @config['hangouts_redirection_url']
  end
end