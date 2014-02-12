class MessagesController < ApplicationController
  include ActionController::Live
  before_action :authenticate

  def index
    @messages = current_user.received_messages
  end

  def create
    response.headers["Content-Type"] = "text/javascript"
    attributes = params.require(:message).permit(:content, :reciver_id)
    @message = Message.create(attributes)
    @message.sender = current_user
    $redis.publish('messages.create', @message.to_json)
  end
  
  def events
    response.headers["Content-Type"] = "text/event-stream"
    redis = Redis.new
    redis.psubscribe('messages.*') do |on|
      on.pmessage do |pattern, event, data|
        response.stream.write("event: #{event}\n")
        response.stream.write("data: #{data}\n\n")
      end
    end
  rescue IOError
    logger.info "Stream closed"
  ensure
    redis.quit
    response.stream.close
  end
end