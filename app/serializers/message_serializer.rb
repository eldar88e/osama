class MessageSerializer
  include Alba::Resource

  root_key :message

  attributes :id, :conversation_id, :direction, :text, :created_at
end
