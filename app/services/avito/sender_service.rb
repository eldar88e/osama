module Avito
  class SenderService
    include AvitoConcerns

    def initialize(text, chat_id)
      @text = text
      @chat_id = chat_id
    end

    def self.call(text, chat_id)
      new(text, chat_id).call
    end

    def call
      set_account
      url      = msg_url(1)
      payload  = { message: { text: params[:msg] }, type: 'text' }
      fetch_and_parse(url, :post, payload)
      1
    end

    private

    def msg_url(version = 3)
      "https://api.avito.ru/messenger/v#{version}/accounts/#{@account['id']}/chats/#{@chat_id}/messages"
    end
  end
end
