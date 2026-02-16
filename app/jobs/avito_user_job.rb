class AvitoUserJob < ApplicationJob
  queue_as :default

  def perform(**args)
    Webhooks::Avito::UserInfo.call(**args)
  end
end
