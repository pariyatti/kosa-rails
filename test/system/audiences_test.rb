require "application_system_test_case"

class AudiencesTest < ApplicationSystemTestCase
  setup do
    @audience = audiences(:one)
  end

  test "visiting the index" do
    visit audiences_url
    assert_selector "h1", text: "Audiences"
  end

  test "creating a Audience" do
    visit audiences_url
    click_on "New Audience"

    fill_in "Name", with: @audience.name
    click_on "Create Audience"

    assert_text "Audience was successfully created"
    click_on "Back"
  end

  test "updating a Audience" do
    visit audiences_url
    click_on "Edit", match: :first

    fill_in "Name", with: @audience.name
    click_on "Update Audience"

    assert_text "Audience was successfully updated"
    click_on "Back"
  end

  test "destroying a Audience" do
    visit audiences_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Audience was successfully destroyed"
  end
end
