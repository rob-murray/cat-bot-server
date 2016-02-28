class MainController < ApplicationController
  def activity
    @heartbeat = Heartbeat.latest
  end
end
