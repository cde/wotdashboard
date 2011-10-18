class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.date :starts_date
      t.date :ends_date
      t.string :title
      t.text :note
      t.references :user
      t.references :graphic

      t.timestamps
    end
  end
end
