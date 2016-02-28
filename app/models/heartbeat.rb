class Heartbeat < ApplicationRecord
  validates :message, presence: true

  after_create_commit { HeartbeatBroadcastJob.perform_later(self) }

  def self.latest
    order(:created_at).last
  end
end
