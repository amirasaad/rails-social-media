# frozen_string_literal: true

class ConversationsController < ApplicationController
  before_action :require_user!
  before_action :set_conversation, except: [:index]

  def index
    session[:conversations] ||= []
    @conversations = Conversation.participating(current_user).find(session[:conversations])
    @users = current_user.followed_users.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @conversation = Conversation.get(current_user.id, params[:user_id])

    add_to_conversations unless conversated?

    respond_to do |format|
      format.js
    end
  end

  def show
    @personal_message = PersonalMessage.new
  end

  def new
    redirect_to conversation_path(@conversation) and return if @conversation

    @personal_message = current_user.personal_messages.build
  end

  def close
    session[:conversations].delete(@conversation.id)

    respond_to do |format|
      format.js
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find_by(id: params[:id])
  end

  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  def conversated?
    session[:conversations].include?(@conversation.id)
  end
end
