class MessagesController < ApplicationController

  def create
    @message = current_user.messages.new(message_params)
    @message.save
  end

  private
  def message_params
    params.require(:message).permit(:message, :room_id)
  end
end
