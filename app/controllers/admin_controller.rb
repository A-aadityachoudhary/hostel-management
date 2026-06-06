class AdminController < ApplicationController
  before_action :authorize_admin! # Use the method we created earlier

  def index
    @students = User.where(role: :student)
    @rooms = Room.all
  end
end