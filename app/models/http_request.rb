module HttpRequest
  def options
    headers = self.headers || Hash.new
    hash = {headers: headers}
    unless body.nil?
      hash.merge({body: body})
    end
    hash
  end
end