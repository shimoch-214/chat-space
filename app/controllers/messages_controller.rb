class MessagesController < ApplicationController
  def index
    @user_groups = current_user.groups
    @group = Group.find(create_params[:group_id])
  end

  private
  def create_params
    params.permit(:group_id)
  end
end
