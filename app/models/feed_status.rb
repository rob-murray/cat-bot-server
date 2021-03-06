class FeedStatus
  def self.from_heartbeat(heartbeat)
    new(
      next_feed: heartbeat.next_feed,
      remaining_feeds: heartbeat.remaining_feeds,
      updated_at: heartbeat.created_at
    )
  end

  attr_reader :next_feed, :remaining_feeds, :updated_at

  def initialize(next_feed:, remaining_feeds:, updated_at:)
    @next_feed = next_feed
    @remaining_feeds = remaining_feeds
    @updated_at = updated_at
  end
end
