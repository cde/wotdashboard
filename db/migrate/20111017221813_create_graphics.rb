class CreateGraphics < ActiveRecord::Migration
  def change
    create_table :graphics do |t|
      t.string :title
      t.text :description
      t.string :chart_type
      t.timestamps
    end
  end
end
