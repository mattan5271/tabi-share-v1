class User::MessagesController < ApplicationController
  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(message_params)
      redirect_to user_room_path(@message.room_id)
    else
      redirect_to user_users_path
    end
  end

  private
    def message_params
      params.require(:message).permit(:user_id, :body, :room_id).merge(:user_id => current_user.id)
    end
end
