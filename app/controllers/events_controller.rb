class EventsController < ApplicationController
  protect_from_forgery with: :null_session
  prepend_before_action :authenticate_user_from_token!
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

  # replicate devise token auth; https://gist.github.com/josevalim/fb706b1e933ef01e4fb6
  def authenticate_user_from_token!
    user_email = params[:user_email].presence
    user       = user_email && User.find_by_email(user_email)

    if user && Devise.secure_compare(user.authentication_token, params[:user_token])
      sign_in user, store: false
    end
  end
end
