module HttpRequest
  def to_net_request
    request      = Net::HTTP::Post.new(request.url)
    request.body = request.body.to_json
    request.headers.each do |key, value|
      request[key] = value
    end
    request
  end
end