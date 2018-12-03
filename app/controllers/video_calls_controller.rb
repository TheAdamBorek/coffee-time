class VideoCallsController < ApplicationController
  rescue_from Coffee::NotURLFormatError, with: :render_wrong_url_format

  def update_link
    params = update_params
    link = params[:text]
    VideoCall.update_link(link)
    render json: {'text': "I've changed the link to #{link}"}, status: :ok
  end

  private

  def update_params
    params.permit(:text)
  end

  def render_wrong_url_format
    render json: {'text': "Given text is not an URL"}, status: :bad_request
  end
end
