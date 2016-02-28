class HeartbeatBroadcastJob < ApplicationJob
  queue_as :default

  def perform(heartbeat)
    ActionCable.server.broadcast "activity_channel", heartbeat: heartbeat.to_json
  end
end
