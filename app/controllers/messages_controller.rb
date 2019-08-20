class MessagesController < ApplicationController
  before_action :set_group, :set_new_message, :set_messages

  def index
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to group_messages_path
    else
      flash.now[:alert] = "メッセージを入力してください。"
      render :index
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(params.permit(:group_id)).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_new_message
    @new_message = Message.new
  end

  def set_messages
    @messages = @group.messages.order('created_at asc').includes(:user)
  end
end
