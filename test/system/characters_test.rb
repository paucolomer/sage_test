require "application_system_test_case"

class CharactersTest < ApplicationSystemTestCase
  test "viewing the index" do
    visit characters_path
    assert_selector "h1", text: "Characters"

    # Check table structure
    within ".table" do
    	assert_selector "th:nth-of-type(1)", text: "Name"
    	assert_selector "th:nth-of-type(2)", text: "Image"
    	assert_selector "th:nth-of-type(3)", text: "Status"
    	assert_selector "th:nth-of-type(4)", text: "Episodes"
    	assert_selector "th", count: 4
    	assert_selector "tr", count: 11
    end

    # Move to the next page
    within ".pagy-header" do
    	assert_text "68"
    	assert_no_text "69"
	  	find(".next > a").click
	  	assert_selector ".active > a", text: "2"
    end
    within ".pagy-footer" do
    	assert_text "68"
    	assert_no_text "69"
    	assert_selector ".active > a", text: "2"
    end

    # Move to the next page
    within ".pagy-footer" do
			first(".next > a").click
			assert_selector ".active > a", text: "3"
		end
		within ".pagy-header" do
			assert_selector ".active > a", text: "3"
		end    
  end
end
