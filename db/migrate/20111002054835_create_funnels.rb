class CreateFunnels < ActiveRecord::Migration
  def change
    create_table :funnels do |t|
      t.string :traffic_type
      t.integer :confirmed
      t.integer :logged_in
      t.integer :first_battle
      t.integer :first_upgrade
      t.integer :tank_purchase
      t.date :start_date
      t.date :end_date
      t.references :report

      t.timestamps
    end
  end
end
