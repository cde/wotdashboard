class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.date :starts_date
      t.date :ends_date
      t.string :title
      t.text :note
      t.string :data
      t.references :user
      t.references :graphic

      t.timestamps
    end
  end
end
