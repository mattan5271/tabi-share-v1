class User::MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      room = Room.find(params[:message][:room_id])
      another_entry = room.entries.find_by('user_id != ?', current_user.id)
      @message = Message.create(message_params)
      current_user.create_notification_message!(current_user, @message.id, another_entry.user_id)
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
