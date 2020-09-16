class CreateInterviewees < ActiveRecord::Migration[5.1]
  def change
    create_table :interviewees do |t|
      t.text :email
      t.text :name
      t.text :clg
      t.float :cgpa

      t.timestamps
    end
  end
end
