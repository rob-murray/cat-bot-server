class MainController < ApplicationController
  def activity
    @current_feed_status = FeedStatus.from_heartbeat(Heartbeat.latest)
    @latest_events = Heartbeat.recent
  end
end
