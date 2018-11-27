require 'httparty'

class HttpClient
  def get(url)
    HTTParty.get(url)
  end

  def post(url, options)
    HTTParty.post(url, options)
  end
end