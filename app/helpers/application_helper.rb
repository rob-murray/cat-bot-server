module ApplicationHelper
  def format_event_payload(event)
    event.payload.attributes.map { |k,v| "#{k}: #{v}" }.join(", ")
  end
end
