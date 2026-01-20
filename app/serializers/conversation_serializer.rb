class ConversationSerializer
  include Alba::Resource

  root_key :conversation

  attributes :id, :source, :created_at, :user_id

  attribute :user do |conversation|
    conversation.user&.full_name
  end
end
