class HttpClient
  def post(request)
    Thread.start do
      http             = Net::HTTP.new(request.url.hostname, request.url.port)
      http.use_ssl     = true
      net_request      = Net::HTTP::Post.new(request.url)
      net_request.body = request.body.to_json
      request.headers.each do |key, value|
        net_request[key] = value
      end
      http.request(net_request)
    end
  end
end
