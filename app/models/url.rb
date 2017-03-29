class Url < ActiveRecord::Base
  require "net/http"

  before_validation :generate_shorty
  validates :original_url, presence: true, format: {with: URI::regexp(%w(http https)), message: "URL must start with http:// or https://"}, uniqueness: {case_sensitive:false}
  validates :shorty, uniqueness: true, presence: true

  private

  def generate_shorty
    if self.new_record? && url_exist?
      begin
        var = Time.now.to_s
        self.shorty = Digest::MD5.hexdigest(var).slice(0..6)
      end while self.class.exists?(shorty: shorty)
    end
  end

  def url_exist?
    begin
      url = URI.parse(original_url)
      req = Net::HTTP.new(url.host, url.port)
      p (url.scheme == 'https')
      req.use_ssl = (url.scheme == 'https')
      path = url.path if url.path.present?
      res = req.request_head(path || '/')
      res.code != "404"
    rescue => e
      p e.inspect
      errors.add(:original_url, "Problem with the original_url")
      return false
    end
  end

end
