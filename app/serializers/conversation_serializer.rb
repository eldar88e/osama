class ConversationSerializer
  include Alba::Resource

  root_key :conversation

  attributes :id, :source, :created_at, :last_message_at, :user_id

  attribute :user do |conversation|
    conversation.user&.full_name
  end

  attribute :photo_url do |conversation|
    conversation.user&.photo_url
  end
end
