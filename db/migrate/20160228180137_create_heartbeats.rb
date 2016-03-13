class CreateHeartbeats < ActiveRecord::Migration[5.0]
  def change
    create_table :heartbeats do |t|
      t.jsonb :payload, null: false, default: {}

      t.timestamps null: false
    end
  end
end
