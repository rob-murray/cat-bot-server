class Heartbeat < ApplicationRecord
  validates :message, presence: true

  after_create_commit { HeartbeatBroadcastJob.perform_later(self) }

  def self.latest
    order(:created_at).last
  end

  def self.recent
    order(:created_at).last(5)
  end

  def name
    "Heartbeat"
  end
end
