class CreateCovidReports < ActiveRecord::Migration[6.0]
  def change
    create_table :covid_reports do |t|
      t.date :date
      t.string :name
      t.string :gender
      t.integer :age
      t.string :city
      t.string :state
      t.string :county
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
