class PagesController < ApplicationController
	
  def homepage
		@user=User.new
		@recent_comments = Comment.order( 'created_at DESC').all.page(params[:page]).per(8)
		@top_stations = Station.order('counter_honesty + counter_speed_service + counter_customer_service DESC').limit(5)
  end
end