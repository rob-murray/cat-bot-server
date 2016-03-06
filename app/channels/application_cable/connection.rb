# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      verified_user = User.find_by(id: cookies.signed['user.id'])
      expiration_time = cookies.signed['user.expires_at']
      if verified_user && expiration_time && (expiration_time > Time.current)
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
