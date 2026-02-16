module Webhooks
  module Avito
    class UserInfo
      def initialize(**args)
        @user_id = args[:user_id]
        @chat_id = args[:chat_id]
        @user    = User.find(@user_id)
      end

      def self.call(**args)
        new(**args).call
      end

      def call
        avito_id = fetch_avito_user['id']
        url      = "https://api.avito.ru/messenger/v2/accounts/#{avito_id}/chats/#{@chat_id}"
        response = AvitoService.new.connect_to(url)
        if response&.success?
          result = JSON.parse(response.body)
          client = result['users'].find { |u| u['id'] != @user_id }
          @user.update!(first_name: client['name'], photo_url: client.dig('public_user_profile', 'avatar', 'default'))
        else
          Rails.logger.error "Failed to get user info. Status: #{response&.status}"
        end
      end

      private

      def fetch_avito_user
        Rails.cache.fetch(:account_avito, expires_in: 1.day) do
          response = AvitoService.new.connect_to('https://api.avito.ru/core/v1/accounts/self')
          JSON.parse(response.body)
        end
      end
    end
  end
end
