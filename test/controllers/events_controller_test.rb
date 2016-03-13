class EventsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def valid_params
    { event: { name: "heartbeat", payload: { next_feed: "evening", remaining_feeds: 1 }}}
  end

  def invalid_params
    { event: { name: "heartbeat", payload: {}}}
  end

  def api_user
    @api_user ||= User.create(email: "test@test.com", password: "anything")
  end

  def teardown
    sign_out api_user
  end

  test "with valid heartbeat event it should create heartbeat model" do
    sign_in api_user

    assert_difference('Heartbeat.count') do
      post :create, params: valid_params
    end
  end

  test "with valid heartbeat event should respond with created" do
    sign_in api_user

    post :create, params: valid_params
    assert_response :created
  end

  test "with invalid params it should not create heartbeat" do
    sign_in api_user

    assert_no_difference('Heartbeat.count') do
      post :create, params: invalid_params
    end
  end

  test "with invalid params it should respond with error" do
    sign_in api_user

    post :create, params: invalid_params
    assert_response :internal_server_error
  end

  test "with unauthenticated user it should forbid" do
    post :create, params: valid_params
    assert_response :redirect
  end

  test "with unauthenticated user it should not create heartbeat" do
    assert_no_difference('Heartbeat.count') do
      post :create, params: valid_params
    end
  end
end
