class HomeController < ApplicationController
  # This will run for every action in this controller 
  skip_authorization_check
  def index
    # your code
  end
end