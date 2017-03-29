require 'test_helper'

class UrlsControllerTest < ActionController::TestCase
  setup do
    @url = urls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:urls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create url" do
    assert_difference('Url.count') do
      post :create, url: { original_url: "http://example3.com", shorty: "mystring3" }
    end

    assert_redirected_to url_path(assigns(:url))
  end

  test "should show url" do
    get :show, id: @url
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @url
    assert_response :success
  end

  test "should update url" do
    patch :update, id: @url, url: { original_url: @url.original_url, shorty: @url.shorty }
    assert_redirected_to url_path(assigns(:url))
  end

  test "should destroy url" do
    assert_difference('Url.count', -1) do
      delete :destroy, id: @url
    end
    assert_redirected_to urls_path
  end

  test "Should redirect_to original_url" do
    get :out_url, shorty: @url.shorty
    assert_redirected_to @url.original_url
  end

end