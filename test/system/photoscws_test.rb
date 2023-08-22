require "application_system_test_case"

class PhotoscwsTest < ApplicationSystemTestCase
  setup do
    @photoscw = photoscws(:one)
  end

  test "visiting the index" do
    visit photoscws_url
    assert_selector "h1", text: "Photoscws"
  end

  test "should create photoscw" do
    visit photoscws_url
    click_on "New photoscw"

    fill_in "Date", with: @photoscw.date
    fill_in "Description", with: @photoscw.description
    fill_in "Location", with: @photoscw.location
    fill_in "Title", with: @photoscw.title
    click_on "Create Photoscw"

    assert_text "Photoscw was successfully created"
    click_on "Back"
  end

  test "should update Photoscw" do
    visit photoscw_url(@photoscw)
    click_on "Edit this photoscw", match: :first

    fill_in "Date", with: @photoscw.date
    fill_in "Description", with: @photoscw.description
    fill_in "Location", with: @photoscw.location
    fill_in "Title", with: @photoscw.title
    click_on "Update Photoscw"

    assert_text "Photoscw was successfully updated"
    click_on "Back"
  end

  test "should destroy Photoscw" do
    visit photoscw_url(@photoscw)
    click_on "Destroy this photoscw", match: :first

    assert_text "Photoscw was successfully destroyed"
  end
end
