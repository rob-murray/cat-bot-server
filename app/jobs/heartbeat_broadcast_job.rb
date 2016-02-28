class HeartbeatBroadcastJob < ApplicationJob
  queue_as :default

  def perform(heartbeat)
    ActionCable.server.broadcast "activity_channel",  { event_type: "heartbeat", content: render_heartbeat(heartbeat) }
  end

  private

  def render_heartbeat(heartbeat)
    ApplicationController.renderer.render(partial: "heartbeats/heartbeat", locals: { heartbeat: heartbeat })
  end
end
