class ApplicationController < ActionController::Base
	include Pagy::Backend

	rescue_from Pagy::OverflowError, :with => :page_not_found

	def page_not_found
		respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404.html", status: 404, layout: false }
    end
	end
end
