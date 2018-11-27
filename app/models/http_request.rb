module HttpRequest
  def to_net_request
    request      = Net::HTTP::Post.new(self.url)
    request.body = body.to_json
    headers.each do |key, value|
      request[key] = value
    end
    request
  end
end