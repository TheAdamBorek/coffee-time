class HttpClient
  def post(request)
    http         = Net::HTTP.new(request.url.hostname, request.url.port)
    http.use_ssl = true
    http.request(request.to_net_request)
  end
end
