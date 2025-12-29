class ApiSession < ApplicationRecord
  belongs_to :user

  scope :active, -> {
    where(revoked_at: nil)
      .where('expires_at > ?', Time.current)
  }

  def self.authenticate(session_id, user_id)
    session = find_by(id: session_id, user_id: user_id)
    return if session.nil?
    return if session.revoked?
    return if session.expired?

    session
  end

  def revoke!
    update!(revoked_at: Time.current)
  end

  def revoked?
    revoked_at.present?
  end

  def expired?
    expires_at <= Time.current
  end
end
