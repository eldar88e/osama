class ConversationChannel < ApplicationCable::Channel
  def subscribed
    conversation = Conversation.find(params[:conversation_id])
    Rails.logger.error '*' * 30
    Rails.logger.warn conversation
    Rails.logger.warn params
    Rails.logger.error '#' * 30
    if conversation
      stream_for conversation
    else
      reject
    end
  end

  def unsubscribed
    stop_all_streams
  end
end
