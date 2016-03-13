class EventsControllerTest < ActionController::TestCase
  def valid_params
    { event: { name: "heartbeat", payload: { next_feed: "evening", remaining_feeds: 1 }}}
  end

  def invalid_params
    { event: { name: "heartbeat", payload: {}}}
  end

  test "with valid heartbeat event it should create heartbeat model" do
    assert_difference('Heartbeat.count') do
      post :create, params: valid_params
    end
  end

  test "with valid heartbeat event should respond with created" do
    post :create, params: valid_params
    assert_response :created
  end

  test "with invalid params it should not create heartbeat" do
    assert_no_difference('Heartbeat.count') do
      post :create, params: invalid_params
    end
  end

  test "with invalid params it should respond with error" do
    post :create, params: invalid_params
    assert_response :internal_server_error
  end

  test "with unauthenticated user it should forbid"
end
