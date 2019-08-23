class Api::UsersController < ApplicationController
  def index
    @users = User.where('name LIKE(?)',"%#{params[:keyword]}%").where("id != #{current_user.id}")
  end
end