class HeartbeatPayload
  include Virtus.model

  attribute :next_feed, String, default: ""
  attribute :remaining_feeds, Integer, default: 0

  def self.dump(payload)
    payload.to_hash
  end

  def self.load(payload)
    new(payload)
  end
end

class Heartbeat < ApplicationRecord
  serialize :payload, HeartbeatPayload

  delegate :next_feed, :remaining_feeds, to: :payload

  validates :payload, presence: true
  validates :next_feed, presence: true
  validates :remaining_feeds, numericality: { only_integer: true }

  after_create_commit { HeartbeatBroadcastJob.perform_later(self) }

  def self.latest
    order(:created_at).last
  end

  def self.recent
    order(created_at: :desc).last(5)
  end

  def self.build_from(payload)
    new(
      payload: HeartbeatPayload.new(
        next_feed: payload[:next_feed],
        remaining_feeds: payload[:remaining_feeds]
      )
    )
  end

  def name
    "Heartbeat"
  end
end
