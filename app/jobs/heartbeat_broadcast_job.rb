class HeartbeatBroadcastJob < ApplicationJob
  queue_as :default

  def perform(heartbeat)
    ActionCable.server.broadcast "activity_channel",
      {
        event_type: "heartbeat",
        event_row: render_heartbeat(heartbeat),
        feed_status_content: render_feed_status(heartbeat)
      }
  end

  private

  def render_heartbeat(heartbeat)
    ApplicationController.renderer.render(
      partial: "events/event_row", locals: { event: heartbeat }
    )
  end

  def render_feed_status(heartbeat)
    ApplicationController.renderer.render(
      partial: "feeds/feed_status", locals: { feed_status: heartbeat }
    )
  end
end
