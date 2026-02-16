module Api
  module V1
    module Conversations
      class UsersController < Api::V1::ApplicationController
        before_action :set_conversation

        def create
          # TODO: Add authorization check
          user = set_user
          if user.save
            @conversation.update(user: user) # last_message_at: Time.current
            AvitoUserJob.perform_later(user_id: user.id, chat_id: @conversation.external_id)
            render json: { data: UserSerializer.new(user) }, status: :created
          else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_content
          end
        end

        private

        def set_conversation
          @conversation = Conversation.find(params[:conversation_id])
        end

        def set_user
          return save_user_from_avito if @conversation.source == 'avito'

          meta = @conversation.meta

          User.find_or_initialize_by(tg_id: meta['telegram_user_id']) do |user|
            user.first_name = meta['first_name']
            user.last_name = meta['last_name']
            user.username = meta['username']
            user.photo_url = meta['photo_url']
          end
        end

        def save_user_from_avito
          meta = @conversation.meta
          User.find_or_initialize_by(avito_id: meta['author_id'])
        end
      end
    end
  end
end
