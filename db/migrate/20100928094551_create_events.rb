class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.datetime :first
      t.integer :recurring_type_id
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
