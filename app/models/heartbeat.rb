class Heartbeat < ApplicationRecord
  validates :message, presence: true
end
