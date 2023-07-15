# frozen_string_literal: true

class PersonalMessagesController < ApplicationController
  def create
    @conversation = Conversation.includes(:receiver).find(params[:conversation_id])
    @message = @conversation.personal_messages.new(message_params)

    respond_to do |format|
      if @message.save
        format.js
      else
        format.js { render 'fail_create.js.erb' }
      end
    end
  end

  private

  def message_params
    params.require(:personal_message).permit(:user_id, :body)
  end
end
