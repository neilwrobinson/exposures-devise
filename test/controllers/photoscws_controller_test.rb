require "test_helper"
# FIXME: to fix carrierwave tests (get and show)
# TODO: to update carrierwave tests
class PhotoscwsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:user_one)
    @photoscw = photoscws(:one)
    @tag = tags(:one)
  end

  test "should get index" do
    get photoscws_url
    assert_response :success
  end

  test "should get new" do
    get new_photoscw_url
    assert_response :success
  end

  test "should create photoscw" do
    assert_difference("Photoscw.count") do
      post photoscws_url, params: { 
        photoscw: { date: @photoscw.date, 
                    description: @photoscw.description, 
                    location: @photoscw.location, 
                    title: @photoscw.title } 
      }
    end

    assert_redirected_to photoscw_url(Photoscw.last)
  end

  test "should show photoscw" do
    get photoscw_url(@photoscw)
    assert_response :success
  end

  test "should get edit" do
    get edit_photoscw_url(@photoscw)
    assert_response :success
  end

  test "should update photoscw" do
    patch photoscw_url(@photoscw), params: { 
      photoscw: { date: @photoscw.date, 
                  description: @photoscw.description, 
                  location: @photoscw.location, 
                  title: @photoscw.title } 
    }
    assert_redirected_to photoscw_url(@photoscw)
  end

  test "should destroy photoscw" do
    assert_difference("Photoscw.count", -1) do
      delete photoscw_url(@photoscw)
    end

    assert_redirected_to photoscws_url
  end
end
