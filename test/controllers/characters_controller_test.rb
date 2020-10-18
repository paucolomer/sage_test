require 'test_helper'

class CharactersControllerTest < ActionDispatch::IntegrationTest
	test "can see index page" do
		get "/"
		assert_response :success
		assert_select "h1", "Characters"

		# Move to page 2
		get "/", params: {page: 2}
		assert_response :success
		assert_select "h1", "Characters"

		assert_select ".pagy-header li.active a", "2"
		assert_select ".pagy-footer li.active a", "2"

		assert_select ".table" do
			assert_select "th", 4
			assert_select "tr", 11
		end

		# Move to page 3
		get "/characters", params: {page: 3}
		assert_response :success
		assert_select "h1", "Characters"

		assert_select ".table" do
			assert_select "th", 4
			assert_select "tr", 11
		end

		assert_select ".pagy-header li.active a", "3"
		assert_select ".pagy-footer li.active a", "3"

		# Move to the last page
		get "/characters", params: {page: 68}

		assert_select ".table" do
    	assert_select "th:nth-of-type(1)", text: "Name"
    	assert_select "th:nth-of-type(2)", text: "Image"
    	assert_select "th:nth-of-type(3)", text: "Status"
    	assert_select "th:nth-of-type(4)", text: "Episodes"
			assert_select "th", 4
			assert_select "tr", 2
		end
	end
end
