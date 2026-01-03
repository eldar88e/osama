class CustomDeviseMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers

  layout 'mailer'

  default template_path: 'devise/mailer'

  def confirmation_instructions(record, _token, _opts = {})
    # nothing not send because email is generated with system
    # TODO: Restore confirmation email
    Rails.logger.warn "Confirmation instructions for #{record.email} not sent"
  end
end
