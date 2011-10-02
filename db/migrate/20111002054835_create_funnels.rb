class CreateFunnels < ActiveRecord::Migration
  def change
    create_table :funnels do |t|
      t.string :type
      t.integer :confirmed
      t.integer :logged_in
      t.integer :first_upgrade
      t.integer :tank_purchase
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
