class Admin::DashboardController < ApplicationController
  before_action :authenticate

def authenticate
  authenticate_or_request_with_http_basic do |username, password|
   username == ENV["USERNAME"] && password == ENV["PASSWORD"]
  end
end

  def show
  end
end
