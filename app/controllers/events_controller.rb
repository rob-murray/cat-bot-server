class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!
  respond_to :json

  if Rails.env.production?
    rescue_from Exception, with: :something_went_wrong
  end

  # Endpoint for incoming events from client
  # JSON only
  # POST /events, { event: { name: "heartbeat", payload: { next_feed: "evening", remaining_feeds: 1 }}}
  def create
    if create_heartbeat
      head :created
    else
      head :internal_server_error
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :payload).tap do |whitelisted|
      whitelisted[:payload] = params[:event][:payload]
    end
  end

  def create_heartbeat
    payload = event_params.fetch(:payload) || {} # why does this behave different to hash now :(
    Heartbeat.build_from(payload).save
  end

  def something_went_wrong
    render json: { error: "Something went wrong" }, status: :internal_server_error
  end
end
