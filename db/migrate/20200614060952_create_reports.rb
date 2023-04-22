class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
    	t.date :date
    	t.string :name
    	t.string :gender
    	t.integer :age
    	t.string :city
    	t.string :state
    	t.string :county
    	t.decimal :latitude, precision: 13, scale: 10
    	t.decimal :longitude, precision: 13, scale: 10
    end
  end
end
