class MessagesController < ApplicationController
  def index
    @user_groups = current_user.groups
    @group = Group.find(message_params[:group_id])
    @messages = @group.messages.order('created_at, desc')
  end

  def create
    @message = Message.new(message_params.merge(user_id: current_user.id))
    if @message.save
      redirect_to :index
    else
      render :index
    end
  end

  private
  def message_params
    params.permit(:group_id)
  end
end
