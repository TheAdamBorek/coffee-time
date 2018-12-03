class VideoCall < ApplicationRecord
  def self.instance
    VideoCall.last || VideoCall.new
  end

  def self.update_link(link)
    call = VideoCall.instance
    call.link = link
    call.save
  end
end
