class MessagesController < ApplicationController
  def index
    @user_groups = current_user.groups
    @new_message = Message.new
    @group = Group.find(params[:group_id])
    @messages = Message.get_sorted_messages(@group).includes(:user)
  end

  def create
    @message = Message.new(message_params.merge(user_id: current_user.id))
    if @message.save
      redirect_to group_messages_path
    else
      redirect_to group_messages_path, alert: "メッセージを入力してください。"
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(params.permit(:group_id))
  end
end
