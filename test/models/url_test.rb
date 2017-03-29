require 'test_helper'

class UrlTest < ActiveSupport::TestCase

  setup do
    @url = urls(:one)
  end

  test "Should not create short_url with empty shorty or original_url" do
    url = Url.new(original_url: nil)
    assert_not url.valid?
    assert url.errors[:original_url].any?
  end

  test "empty path is bad" do
    url = Url.new(original_url: 'http://')
    assert_not url.valid?
    assert url.errors[:original_url].any?
    assert_equal "Original url Problem with the original_url", url.errors.full_messages.first
  end

end
