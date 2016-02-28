class Heartbeat < ApplicationRecord
  validates :message, presence: true

  after_create_commit { HeartbeatBroadcastJob.perform_later(self) }
end
