VALID_URL_REGEX = /^#{URI::regexp(%w(http https))}$/

class NotURLFormatError < StandardError
  def initialize(msg = "Not an URL format")
    super
  end
end