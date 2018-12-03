class VideoCall < ApplicationRecord
  after_initialize :set_default_link_if_blank

  def set_default_link_if_blank
    self.link ||= AppConfig.instance.hangouts_redirect_url
  end

  def self.instance
    VideoCall.last || VideoCall.new
  end

  def self.update_link(link)
    unless link =~ VALID_URL_REGEX
      raise NotURLFormatError.new
    end
    uri       = URI(link)
    call      = VideoCall.instance
    call.link = uri.to_s
    call.save
  end
end
