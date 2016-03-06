# Set and destroy signed cookie after sign in/out for ActionCable
# http://www.rubytutorial.io/actioncable-devise-authentication/
Warden::Manager.after_set_user do |user,auth,opts|
  scope = opts[:scope]
  auth.cookies.signed["#{scope}.id"] = user.id
  auth.cookies.signed["#{scope}.expires_at"] = Time.current + 30.minutes
end

Warden::Manager.before_logout do |user, auth, opts|
  scope = opts[:scope]
  auth.cookies.signed["#{scope}.id"] = nil
  auth.cookies.signed["#{scope}.expires_at"] = nil
end
