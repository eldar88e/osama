class ApiSession < ApplicationRecord
  belongs_to :user

  EXPIRES_IN = 7.days

  before_validation :set_expires_at

  validates :expires_at, presence: true
  validates :refresh_token_digest, presence: true, uniqueness: true

  scope :active, -> { where(revoked_at: nil).where('expires_at > ?', Time.current) }

  def self.authenticate(session_id, user_id)
    session = find_by(id: session_id, user_id: user_id)
    return if session.nil?
    return if session.revoked?

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

  private

  def set_expires_at
    self.expires_at = EXPIRES_IN.from_now if expires_at.blank?
  end
end
