module Admin
  module Avito
    class SettingsController < ApplicationController
      include AvitoConcerns

      before_action :set_webhook_url

      def show
        subscriptions_url = 'https://api.avito.ru/messenger/v1/subscriptions'
        @subscriptions    = fetch_and_parse(subscriptions_url, :post, {})['subscriptions']
      end

      def update
        url =
          if params[:subscription_del]
            'https://api.avito.ru/messenger/v1/webhook/unsubscribe'
          else
            'https://api.avito.ru/messenger/v3/webhook'
          end

        result = fetch_and_parse(url, :post, { url: @webhook_url })
        return error_notice(t('controllers.avito.settings.update.error')) unless result['ok']

        flash[:notice] = t('controllers.avito.settings.update.success')
        redirect_to admin_avito_settings_path
      end

      private

      def set_webhook_url
        @webhook_url = "https://#{ENV.fetch('HOST')}/webhooks/avito"
      end
    end
  end
end
