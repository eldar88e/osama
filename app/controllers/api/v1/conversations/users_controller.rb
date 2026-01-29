module Api
  module V1
    module Conversations
      class UsersController < Api::V1::ApplicationController
        def create
          conversation = Conversation.find(params[:conversation_id])
          meta         = conversation.meta

          user = User.new(
            first_name: meta['first_name'],
            last_name: meta['last_name'],
            tg_id: meta['telegram_user_id'],
            username: meta['username'],
            photo_url: meta['photo_url']
          )

          if user.save
            conversation.update(user: user, last_message_at: Time.current)
            render json: { data: UserSerializer.new(user) }, status: :created
          else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
          end
        end
      end
    end
  end
end
