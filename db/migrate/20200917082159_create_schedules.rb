class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.text :email1
      t.text :email2
      t.datetime :st
      t.datetime :end

      t.timestamps
    end
  end
end
