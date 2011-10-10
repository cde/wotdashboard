class CreateFunnels < ActiveRecord::Migration
  def change
    create_table :funnels do |t|
      t.string :type
      t.integer :confirmed
      t.float :logged_in
      t.float :first_upgrade
      t.float :tank_purchase
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
