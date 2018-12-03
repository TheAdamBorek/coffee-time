class VideoCallsController < ApplicationController
  def update
    params = update_params
    VideoCall.update_link(params[:call_link])
  end

  def update_params
    params.permit(:call_link)
  end
end
