class TelegramJob < ApplicationJob
  queue_as :telegram_notice

  def perform(**args)
    if args[:method] == 'delete_msg'
      Telegram::MsgDelService.remove(args[:id], args[:msg_id])
    else
      Telegram::SenderService.call(args[:msg], args[:id], **args)
    end
  end
end
